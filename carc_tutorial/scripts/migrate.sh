#!/bin/bash
#This script is designed to migrate all of a user's data from the existing project
#filesystem to a comparable new filesystem
project_dir=$1
num_threads=$(( $2 - 1 ))
echo $num_threads

destination_dir=`echo "$project_dir" | sed "s/project/project2/g"`
echo $destination_dir

#Use xargs to parallelize rsync across multiple threads
mkdir $destination_dir
find . -maxdepth 1 -mindepth 1 | xargs -n1 -P $num_threads -I% rsync -arltvvh % $destination_dir
printf "Done syncing directories!"

# #I'm not totally sure about the contents of this line below
# ln -sf $destination_dir $HOME/proj

#Create a checksum hashing of the original project data and check it against the
#copied data
cd $project_dir
find . -type f -exec sha256sum '{}' \; > "$HOME/hash.txt"
cd $destination_dir
sha256sum -c $HOME/hash.txt