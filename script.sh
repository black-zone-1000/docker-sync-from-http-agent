#!/bin/bash
. /env.sh

echo "$(date): executed script"
echo "REMOTE_HOST=${REMOTE_HOST}"
echo "TARGET_FOLDER=${TARGET_FOLDER}"
echo "SOURCE_FOLDER=${SOURCE_FOLDER}"

typeset -i i=0 max=${#REMOTE_HOST[*]}

while (( i < max ))
do
	HOST=${REMOTE_HOST[$i]}
	TARGETFOLDER=${TARGET_FOLDER[$i]}
	SOURCEFOLDER=${SOURCE_FOLDER[$i]}

	echo "syncing from ${HOST}:${SOURCE_FOLDER} to ${TARGET_FOLDER}"

	mkdir ${TARGET_FOLDER}

	lftp -f "
		open $HOST
		set ftp:list-options -a
		mirror -c -e $SOURCEFOLDER $TARGETFOLDER
		bye
	"
	echo "syncing complete"
	i=i+1
done
