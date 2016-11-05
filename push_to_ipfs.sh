#/bin/bash

set -u
set -e

tmpfile=.ipfs_update.tmp

echo "adding recursively..."
ipfs add -r root > $tmpfile

# the top directory hash in the last line, that's convenient!
hash=$(tail -n 1 $tmpfile | cut -f 2 -d ' ')
echo $hash > root_hash.txt
echo "new root hash: $hash - persisted to file root_hash.txt"

node_id=$(ipfs id -f="<id>\n")
echo "updating ipns... (node id: $node_id)"
ipfs name publish $hash > $tmpfile
# example output:
# Published to QmfJ4cFrE5NHwqqsAtwWW3uP2n1emVJQf6H6g71f7ZHs8T: QmXsbfuGCcm91te2hx4aNLGFJhfrWzgvuB4cKebcbBNt8k

#ipns_hash=$(cat $tmpfile | cut -f 3 -d ' ')
# This works for me, but it may be safer to parse this with sed, e.g. in order to avoid failure with localized ipfs client
#ipns_hash=$(sed 's/.*\(\w\{46\}\).*\w\{46\}.*/\1/' $tmpfile)
# but - why did I want to parse this??

echo "all done. enjoy!"

rm $tmpfile
