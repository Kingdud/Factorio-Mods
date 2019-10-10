import json
import re
import sys

def checkfile(fname):
    try:
        the_file = open(fname, 'r')
    except IOError:
        print(fname + ' missing')
        if fname == "data.raw.json":
            print("Download from link on https://wiki.factorio.com/Data.raw then convert with dataraw_to_json")
        elif fname == "recipe_list.json":
            print("File format: Json, copy-paste from your mod. Do not include data:extend. Then run dataraw_to_json The file should start with [ and end with ], if not, make it so")
        elif fname == "build_manifest":
            print("File format: text.\n<Recipe name> <# you want built>")
            print("If you have many nested recipes, say, a new assembler that takes 5 intermediates, each of which need 4 intermediates of their own, you need only specify\nnew-assembler 1\n in the file and this calculator will figure out the rest.")
        sys.exit(1)
    return the_file

def resolveIntermediates(item, multiplier, cost_dict, combined_recipes):
    if item in combined_recipes:
        for element in combined_recipes[item]:
            #handle fluids
            if type(element) is dict:
                if element["name"] in cost_dict:
                    cost_dict[element["name"]] = cost_dict[element["name"]] + element["amount"]*multiplier
            #Handle non-fluids
            elif element[0] in cost_dict:
                cost_dict[element[0]] = cost_dict[element[0]] + element[1]*multiplier
            else:
                resolveIntermediates(element[0], element[1]*multiplier, cost_dict, combined_recipes)
    return cost_dict
#end resolveIntermediates

def print_final_costs(cost_dict, combined_recipes, build_manifest):
    for line in build_manifest:
        values = line.split(" ")
        cost_dict = resolveIntermediates(values[0], int(values[1]), cost_dict, combined_recipes)
    for item in cost_dict:
        print(item + " " + str(cost_dict[item]));
#end print_final_costs

def make_useful_lists(recipes_parsed, d_raw_parsed):
    result = {}

    for item in recipes_parsed:
        index = recipes_parsed.index(item)
        result[item["name"]] = recipes_parsed[index]["ingredients"]

    for item in d_raw_parsed["recipe"]:
        if "ingredients" in d_raw_parsed["recipe"][item]:
            result[item] = d_raw_parsed["recipe"][item]["ingredients"]
        else:
            result[item] = d_raw_parsed["recipe"][item]["normal"]["ingredients"]

    #debug
#    print("---Debug recipes---")
#    for key,value in result.items():
#        print(key,value);
#    print("---End Debug recipes---")

    return result
#end make_useful_lists

def main():
    raw_materials = {
            "iron-ore", 
            "copper-ore", 
            "stone", 
            "crude-oil", 
            "uranium-ore",
            "water",
            "light-oil",
            "petroleum-gas",
            "heavy-oil"
    }
    d_raw = checkfile("data.raw.json")
    recipes_list = checkfile("recipe_list.json")
    try:
        d_raw_parsed = json.load(d_raw)
        recipes_parsed = json.load(recipes_list)
    except:
        print(sys.exc_info())
        sys.exit(1)

    build_manifest = checkfile("build_manifest")

    cost_dict = dict.fromkeys(raw_materials,0)

    combined_recipes = make_useful_lists(recipes_parsed, d_raw_parsed)

    print_final_costs(cost_dict, combined_recipes, build_manifest)

if __name__ == '__main__':
    main()
