#!/bin/bash
. /env.sh

echo "$(date): executed script"
echo "REMOTE_HOST=${REMOTE_HOST[*]}"
echo "TARGET_FOLDER=${TARGET_FOLDER[*]}"
echo "SOURCE_FOLDER=${SOURCE_FOLDER[*]}"

typeset -i i=0 max=${#REMOTE_HOST[*]}

while (( i < max ))
do
	_HOST=${REMOTE_HOST[$i]}
	_TARGETFOLDER=${TARGET_FOLDER[$i]}
	_SOURCEFOLDER=${SOURCE_FOLDER[$i]}

	echo "syncing from ${_HOST}:${_SOURCEFOLDER} to ${_TARGETFOLDER}"

	mkdir ${TARGET_FOLDER}

	lftp -f "
		set net:timeout 5;
		set net:max-retries 3;
		set net:reconnect-interval-multiplier 1;
		set net:reconnect-interval-base 5;
		open $_HOST
		set ftp:list-options -a
		mirror -c -e $_SOURCEFOLDER $_TARGETFOLDER
		bye
	"
	echo "syncing complete"
	i=i+1
done
