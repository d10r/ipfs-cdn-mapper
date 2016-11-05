# ipfs-cdn

This is a simple collection of shell scripts which makes it easy to mirror conventional CDNs on ipfs.
So far adapted only to googleapis CDN.

Example deployment: https://ipfs.io/ipns/QmfJ4cFrE5NHwqqsAtwWW3uP2n1emVJQf6H6g71f7ZHs8T

## How to use
* browse to https://developers.google.com/speed/libraries and choose a lib
* copy the list of versions to a text file, e.g. to `versions/js_jquery.txt`
* remove the commas, e.g. `./remove_commas.sh versions/js_jquery.txt`
* run the download script, e.g. `./download.sh js_jquery.txt jquery root/js/jquery/ jquery googleapis` (see `./download.sh --help`)
* run `./push_to_ipfs.sh`. This adds the directory `root` recursively and updates ipns.

Note that currently ipfs supports only one ipns mapping per node. If you're not yet using ipns on your node, that's not a problem. Otherwise your exising mapping would be replaced.

## Replication
A real CDN requires replication throughout many machines in different locations.
This code's purpose is to easily create an organized directory structure and map the root to ipns in order to allow static URLs while keeping the possibility to add files to the directory tree. It doesn't deal with replication.
However, because of content addressing, replication may be achieved even without people consciously contributing to this CDN. Whenever somebody adds the same file as contained in the root directory to their node, that node automatically becomes a mirror for that file. That's true even if the file is added with a different filename, it just needs to have the exact same content. That's the beauty of content addressing.
(At least this is my understanding about how this works. Let me know if something isn't acurate.)
