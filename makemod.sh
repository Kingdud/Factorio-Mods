#!/bin/bash

BASE_PATH="/cygdrive/c/Users/user/AppData/Roaming/Factorio/My Mods Git"
BASE_PATH_WIN="C:\Users\user\AppData\Roaming\Factorio\My Mods Git"

if [ $# -lt 1 ]
then
	echo "Usage: $0 <mod folder>"
	exit 1
fi

if [ "${str:$i:1}" == '\\' ]
then
	modname=`echo $1 | tr -d '\\'`
else
	modname=$1
fi

version=`grep '"version"' "$BASE_PATH/$modname/info.json" | awk -F: '{print $2}' | tr -d '"' | tr -d ',' | tr -d ' ' | tr -d '\r\n'`

robocopy "$BASE_PATH_WIN\\${modname}" "$BASE_PATH_WIN\\${modname}_${version}" /MIR /S
/cygdrive/c/Program\ Files/7-Zip/7z.exe a -sdel "$BASE_PATH_WIN\\${modname}_${version}.zip" "$BASE_PATH_WIN\\${modname}_${version}"
