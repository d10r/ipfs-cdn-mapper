#/bin/bash

function usage_exit {
	echo "$0 <versionlist file> <libname> <local dir> <filename prefix> <cdn>"
	echo "		currently, only 'googleapis' cdn is implemented"
	exit
}

[[ $1 && $2 && $3 && $4 && $5 ]] || usage_exit

set -e
set -u

versionlistfile=$1
libname=$2
localdir=$3
filenameprefix=$4
cdn=$5

[[ $cdn == "googleapis" ]] || usage_exit


# possible optimization: keep connection open between downloads. Not sure how to do this. 
# curl supports multiple remote file arguments, but how to map this to local files?
for v in `cat $versionlistfile`; do
        remotefile="https://ajax.googleapis.com/ajax/libs/$libname/$v/$filenameprefix.min.js"
        localfile="$filenameprefix-$v.min.js"

	if [[ -f $localdir/$localfile ]]; then
		echo "$localfile already exists, skipping"
		continue
	fi

        echo "retrieving remote: $remotefile"
      	curl $remotefile > $localdir/$localfile
done

