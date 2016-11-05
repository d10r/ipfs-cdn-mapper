#!/bin/bash

# takes a file path as argument
# Supports paths in local file system or on ipfs
# ipfs paths need to start with "/ipfs/"n or "/ipns/"
# If you have that directory structure on your local filesystem, I'm sorry :-)

set -e
set -u

path=$1

# maybe there's a more elegant way to do this?
is_ipfspath=false
if [[ $path == ${path#/ipns/} ]] || [[ $path == ${path#/ipfs/} ]]; then
	ipfspath=$path
else
	ipfspath=$(ipfs add -n $path | cut -f 2 -d ' ')
fi

tmpfile=".ipfs_provs.tmp"
touch $tmpfile
echo "looking for nodes having $ipfspath..."
ipfs dht findprovs $ipfspath | tee $tmpfile
nr_nodes=$(cat $tmpfile | wc -l)
echo
echo "Found on $nr_nodes nodes"
rm $tmpfile
