#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <unistd.h>

/* I mostly wrote this to remind myself how to program in C, because I haven't
 * done that in around a year. But also, because nobody else had an up-to-date
 * and working factorio->JSON converter, and I needed one for my own project.
 */

//Note: cannot be 512k or smaller, has to accommodate the largest top-level-object.
#define CHUNK_SIZE 1024*1024*10
#define TMP_FILE_NAME "/tmp/fix_json_tmpfile"

//[a-zA-Z]
inline int isAlphabetical(char c)
{
	if((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || c == '[') { return 1; }
	return 0;
}//end isAlphabetical

//[0-9\-.]
inline int isNumber(char c)
{
	if((c >= '0' && c <= '9') || c == '-' || c == '.') { return 1; }
    return 0;
}//end isNumber

int findMatchingBrace(int open_brace, char *buf, int charsRead, int *is_double_brace)
{
	int found_alphanum = 0;
	int deeper_dbl_brace = 0;
	int bracketed_field = 0;
	int ret = 0;

	//We have to find the close } first, and determine if there are any { in between
	// which are also on the left-side of an =. We have to do this before anything
	// else because there are some text fields intermixed within double-brace regions
	//As for what happens to text in a double-brace? It's deleted. JSON doesn't support
	// key-value pairs inside of object lists.
	int depth = 0;
	int am_right_of_equals = 0;
	for(int i = open_brace+1; i < charsRead; ++i)
	{
		if(buf[i] == '{' && depth == 0 && !am_right_of_equals)
		{
			++depth;
			*is_double_brace = 1;
			break;
		} else if(buf[i] == '{') { ++depth; }
		else if(buf[i] == '}') {
			--depth; 
			if(depth == 0) { am_right_of_equals = 0; }
		}
		else if(buf[i] == '=') { am_right_of_equals = 1; }

		if(depth == -1) { break; }
	}

	for(int i = open_brace+1; i < charsRead; ++i)
	{
		if(buf[i] == '{')
		{
			ret = findMatchingBrace(i, buf, charsRead, &deeper_dbl_brace);
			//need more data to find match
			if(ret < 0) { return ret; }
			//otherwise, ignore or replace
			if(deeper_dbl_brace)
			{
				buf[i] = '[';
				buf[ret] = ']';
				deeper_dbl_brace = 0;
			}
			i = ret;
		}
		else if(buf[i] == '}') {
			if(bracketed_field)
			{
				buf[open_brace] = '[';
				buf[i] = ']';
			}

			//clean up any dangling ,
			if(*is_double_brace)
			{
				for(int z = i-1; z >= 0; --z)
				{
					if(buf[z] == ',') { buf[z] = ' '; }
					else if(buf[z] != ' ' && buf[z] != '\n') { break; }
				}
			}
			return i;
			
		}
		else if(*is_double_brace && buf[i] != ' ' && buf[i] != ',' && buf[i] != '\n')
		{
			buf[i] = ' ';
			if(buf[i+1] == ',') { buf[i+1] = ' '; }
		}
		else if(!found_alphanum) {
			if(isAlphabetical(buf[i]))
			{
				found_alphanum = 1;
			}
			else if(isNumber(buf[i]) || buf[i] == '"')
			{
				found_alphanum = 1;
				//fields containing just numbers get treated the same as double braces.
				bracketed_field = 1;
			}
		}
	}
	return -1;
}//end findMatchingBrace

int handleBracketsAndBraces(char *buf, int charsRead)
{
	int ret = 0; 
	int is_double_brace = 0;
	int i = 0;

	for(; i < charsRead; ++i)
	{
		if(buf[i] == '{')
		{
			ret = findMatchingBrace(i, buf, charsRead, &is_double_brace);
			//<0 means we couldn't find matching }, need to read more from file.
			if(ret < 0) { return i; }
			else {
				//otherwise ret is the position of the close brace, any intermediate
				// braces were fixed along the way.
				if(is_double_brace) 
				{
					buf[i] = '[';
					buf[ret] = '[';
					is_double_brace = 0;
				}
				i = ret;
			}
		}
	}
	return i;
}//end handleBracketsAndBraces

void sumTimeDiff(struct timeval *start, struct timeval *end, int *seconds, int *millis)
{
	int seconds_end = end->tv_sec*1000000 + end->tv_usec;
	int seconds_start = start->tv_sec*1000000 + start->tv_usec;

	int tmp_seconds = (seconds_end - seconds_start)/1000000;
	int tmp_micros = (seconds_end - seconds_start) - tmp_seconds*1000000;

	int full_value_time = ((*seconds + tmp_seconds)*1000000) + tmp_micros + *millis*1000;
	*seconds = full_value_time / 1000000;
	*millis = (full_value_time - (*seconds*1000000))/1000;
}//end sumTimeDiff

int main(int argc, char **argv)
{
	if(argc < 2)
	{
		printf("%s <input file>\n",argv[0]);
		exit(1);
	}
	
	struct timeval start, end;
	int sed_seconds = 0, sed_millis = 0;
	int prog_seconds = 0, prog_millis = 0;
	int ret = 0;
	gettimeofday(&start, NULL);

	//Read buffer
	char *buffer = (char*)malloc(CHUNK_SIZE);
	if(buffer == NULL)
	{
		exit(7);
	}

	//open input file
	int infile = open(argv[1],O_RDONLY);
	if(infile < 0){
		exit(6);
	}

	//copy input file to tmp location
	int charsRead = read(infile,buffer,CHUNK_SIZE);
	int charsWritten = 0;
	int outfile = open(TMP_FILE_NAME,O_CREAT|O_WRONLY|O_TRUNC,S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH);
	while(charsRead > 0)
	{
		ret = write(outfile,buffer+charsWritten,charsRead);
		if(ret != charsRead && charsRead > 0)
		{
			charsWritten = ret;
			charsRead = charsRead - ret;
		} else {
			charsRead = read(infile,buffer,CHUNK_SIZE);
			charsWritten = 0;
		}
	}
	close(infile);
	close(outfile);
	gettimeofday(&end, NULL);
	sumTimeDiff(&start,&end,&prog_seconds,&prog_millis);
	gettimeofday(&start, NULL);

	//Nils are cancer. We must squash them first.
	int status = 0;
	pid_t pid = fork();
	if(pid == -1) { exit(17); }
	else if(pid > 0) {
		int status;
	    waitpid(pid, &status, 0);
	} else {
		
		execl("/bin/sed","sed","-i","-E","-e","s/\\bnil\\b/\"nil\"/g", TMP_FILE_NAME, NULL);
		return 0;
	}
	gettimeofday(&end, NULL);
	sumTimeDiff(&start,&end,&sed_seconds,&sed_millis);
	gettimeofday(&start, NULL);

	//close original input file, re-open modified input file
	infile = open(TMP_FILE_NAME,O_RDONLY);
    if(infile < 0){
        exit(6);
    }

	int outflen = snprintf(NULL,0,"%s.json",argv[1]);
	++outflen;
	char *tmp = (char*)malloc(outflen);
	snprintf(tmp,outflen,"%s.json",argv[1]);
	outfile = open(tmp,O_CREAT|O_WRONLY|O_TRUNC,S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH);
	if(outfile < 0){
		exit(6);
	}

	charsRead = read(infile, buffer, CHUNK_SIZE);

	//skip over any data before the first {
	for(int i = 0; i < charsRead; ++i)
	{
		if(buffer[i] == '{')
		{
			//Write out the first { to make the rest of the program logic cleaner.
			ret = write(outfile,"{",1);
			if(ret != 1) { exit(12); }
			//overwrite bogus data at start.
			memcpy(buffer,buffer+i+1, charsRead - i - 1);
			charsRead = charsRead - i - 1;
			break;
		}
	}

	int carryover_chars = 0;
	while(charsRead > 0)
	{
		carryover_chars = charsRead - handleBracketsAndBraces(buffer, charsRead);
		//Flush corrected data
		ret = write(outfile,buffer,charsRead - carryover_chars);
		if(ret != charsRead - carryover_chars)
		{
			exit(11);
		}
		//Move data that still needs to be processed to the start of the buffer.
		memcpy(buffer,buffer+charsRead - carryover_chars, carryover_chars);
		//Fill in remaining buffer slots with new data
		charsRead = read(infile,buffer+carryover_chars,CHUNK_SIZE - carryover_chars);
		charsRead += carryover_chars - 1;
	}

	free(buffer);
	close(infile);
	close(outfile);

	gettimeofday(&end, NULL);
	sumTimeDiff(&start,&end,&prog_seconds,&prog_millis);
	gettimeofday(&start, NULL);
	printf("Bracket replacement completed in %d seconds and %d milliseconds. Starting sed.\n",prog_seconds,prog_millis);

	//We use regex to fix a few of the more annoying problems
	//1. Replacing nil with "nil"
	//2. Replacing '<something> =' with '"<something>":'
	//3. Replacing ["hyphen-word"] with "hyphen-word": (note: this one actually takes two passes,
	// and there's an interaction between rules 2 and 3 to get this desired outcome.
	//Most of the runtime of this program is this command. Sed's fast, but we've asked it to do a lot!
	status = 0;
	pid = fork();
	if(pid == -1) { exit(17); }
	else if(pid > 0) {
		int status;
	    waitpid(pid, &status, 0);
	} else {
		execl("/bin/sed","sed","-i","-E","-e","/math.huge/d","-e","s/\\[\"(.+?)\"\\]/\\1/g","-e","s/([^ \t]*) =/\"\\1\":/g", tmp, NULL);
		return 0;
	}

	gettimeofday(&end, NULL);
	sumTimeDiff(&start,&end,&sed_seconds,&sed_millis);
	printf("Sed took %d seconds and %d milliseconds.\n",sed_seconds,sed_millis);

	free(tmp);
	ret = remove(TMP_FILE_NAME);

	return 0;
}
