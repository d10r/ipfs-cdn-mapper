# ipfs-cdn-mapper

This is a collection of simple shell scripts which make it easy to mirror conventional CDNs on ipfs.  
It can import a given list of files to an IPFS node and replicate the directory stucture of the source CDN using IPNS.  

Since this was intended for experimentation, only a single source CDN is supported out of the box: googleapis.  
But it should be pretty easy to replicate the workflow for arbitrary CDNs.

Example deployment: https://ipfs.io/ipns/QmfJ4cFrE5NHwqqsAtwWW3uP2n1emVJQf6H6g71f7ZHs8T (update: this was shut down because of persisting high bandwidth usage of ~20Gb/day. I can't afford to offer actual CDN services for free. May become viabe once Filecoin is ready.)

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
However, because of content addressing of ipfs, replication may be achieved even without people consciously contributing to this CDN. Whenever somebody adds the same file as contained in the root directory to their node, that node automatically becomes a mirror for that file. That's true even if the file is added with a different filename, it just needs to have the exact same content. That's the beauty of content addressing.

In order to check the replication status of a specific file, run the script `check_file_replication.sh`.
For example:

```
./check_file_replication.sh root/js/jquery/jquery-2.2.1.min.js 
file hash is QmXxcr6T2mX9SLeTmLxS5qivVPkbeVfnV6rULrXcV7DXE9 - looking for nodes having it...

QmfJ4cFrE5NHwqqsAtwWW3uP2n1emVJQf6H6g71f7ZHs8T
QmPMrzG3XdTGarMzQ6ozJXTjbgyQB2ZNUaH8QytMsfykX9
QmP6TAKVDCziLmx9NV8QGekwtf7ZMuJnmbeHMjcfoZbRMd
QmSoLMeWqB7YGVLJN3pNLQpmmEk35v6wYtsMGLzSr5QBU3
QmSoLju6m7xTh3DuokvT3886QRYqxAzb1kShaanJgW36yx
QmfHWdVuMdCAywXhGqQ5YWqoK5hn2SeGW8zM9Dx4HhnLhW
QmfPZcnVAEjXABiA7StETRUKkS8FzNt968Z8HynbJR7oci

Found on 7 nodes
```

You can also use an ipns/ipfs paths instead of local files as argument, e.g.
```
./check_file_replication.sh /ipns/QmfJ4cFrE5NHwqqsAtwWW3uP2n1emVJQf6H6g71f7ZHs8T/js/jquery/jquery-2.2.1.min.js
...
```
