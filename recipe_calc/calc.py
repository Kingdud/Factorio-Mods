import argparse
import json
import locale
import re
import sys

def checkfile(fname):
    try:
        the_file = open(fname, 'r')
    except IOError:
        print("Problem opening " + fname)
        sys.exit(1)
    return the_file

def resolveIntermediates(item, multiplier, ltd_cost_dict, ultd_cost_dict, combined_recipes):
    if item in combined_recipes:
        for element in combined_recipes[item]:
            #handle fluids
            if type(element) is dict:
                if element["name"] in ultd_cost_dict:
                    ultd_cost_dict[element["name"]] = ultd_cost_dict[element["name"]] + element["amount"]*multiplier
            #Handle non-fluids
            elif element[0] in ltd_cost_dict:
                ltd_cost_dict[element[0]] = ltd_cost_dict[element[0]] + element[1]*multiplier
            else:
                ltd_cost_dict, ultd_cost_dict = resolveIntermediates(element[0], element[1]*multiplier, ltd_cost_dict, ultd_cost_dict, combined_recipes)
    else:
        print("Error! Cannot find " + item)
    return ltd_cost_dict, ultd_cost_dict
#end resolveIntermediates

def print_final_costs(ltd_cost_dict, ultd_cost_dict, combined_recipes, build_manifest):
    for line in build_manifest:
        values = line.split(" ")
        ltd_cost_dict, ultd_cost_dict = resolveIntermediates(values[0], int(values[1]), ltd_cost_dict, ultd_cost_dict, combined_recipes)

    total_items = 0
    for item in sorted(ltd_cost_dict):
        total_items = total_items + ltd_cost_dict[item]
        print(item + " {:,d}".format(ltd_cost_dict[item]));
    print("Total limited materials: {:,d}\n".format(total_items))
    total_items = 0
    crude_equivilant = 0
    for item in sorted(ultd_cost_dict):
        total_items = total_items + ultd_cost_dict[item]
        if item == "heavy-oil":
            crude_equivilant = crude_equivilant + (ultd_cost_dict[item] / .3)
        if item == "light-oil":
            crude_equivilant = crude_equivilant + (ultd_cost_dict[item] / .525)
        if item == "petroleum-gas":
            crude_equivilant = crude_equivilant + (ultd_cost_dict[item] / .9)
        print(item + " {:,d}".format(ultd_cost_dict[item]));
    print("Total unlimited materials: {:,d}".format(total_items))
    print("Approximate Crude Oil needed: {:,d}\n".format(int(crude_equivilant)))
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
    parser = argparse.ArgumentParser()
    parser.add_argument("-m","--manifest", help="""File format: text.\n<Recipe name> <# you want built>\n
        If you have many nested recipes, say, a new assembler that takes 5 intermediates, each of 
        which need 4 intermediates of their own, you need only specify\nnew-assembler 1\n in the 
        file and this calculator will figure out the rest.""", default="build_manifest")
    parser.add_argument("-r","--recipes", help="""File format: Json, copy-paste from your mod. Do not 
        include data:extend. Then run dataraw_to_json The file should start with [ and end with ], if not, 
        make it so""", default="recipe_list.json")
    parser.add_argument("-d","--data", help="""Download from link on https://wiki.factorio.com/Data.raw 
        then convert with dataraw_to_json""", default="data.raw.json")
    args = parser.parse_args()

    locale.setlocale(locale.LC_ALL, "")#automatic locale

    unlimited_materials = {
            "crude-oil", 
            "water",
            "light-oil",
            "petroleum-gas",
            "heavy-oil"
    }
    limited_raw_materials = {
            "iron-ore", 
            "copper-ore", 
            "stone", 
            "uranium-ore",
    }
    d_raw = checkfile(args.data)
    recipes_list = checkfile(args.recipes)
    try:
        d_raw_parsed = json.load(d_raw)
        recipes_parsed = json.load(recipes_list)
    except:
        print(sys.exc_info())
        sys.exit(1)

    build_manifest = checkfile(args.manifest)

    ltd_cost_dict = dict.fromkeys(limited_raw_materials,0)
    ultd_cost_dict = dict.fromkeys(unlimited_materials,0)

    combined_recipes = make_useful_lists(recipes_parsed, d_raw_parsed)

    print_final_costs(ltd_cost_dict, ultd_cost_dict, combined_recipes, build_manifest)

if __name__ == '__main__':
    main()
