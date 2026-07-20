#!/bin/bash

toprocess=$1
maindir=$2
stain_name=$3
param_file=$4
addtl_subdir=$5

if [ -z "$stain_name" ]; then
    dirnm=$toprocess
else
    dirnm=$stain_name
fi

#basedir='./out/'$toprocess
# normal output dir:
#basedir='./out/'$dirnm
# saving to OneDrive instead:
username=$(whoami)
basedir="C:/Users/"${username}"/OneDrive - cumc.columbia.edu/Colocalization/out/$dirnm"
if [[ -n "$addtl_subdir" ]]; then
    basedir="$basedir/$addtl_subdir"
fi

echo Looking for ID folders in: $maindir
echo Will save output in $basedir

for fl in "$maindir"/*; do
    echo $fl
    # the directory name (the sample id)
    id_dir=$(basename "$fl")
    echo $id_dir
    savedir=${basedir}/${id_dir}
    echo Save directory is $savedir

    # run the main analysis script
    python ./python_scripts/run_cell_count_set_sections.py "$fl" "$savedir" "$toprocess" "$stain_name" "$param_file"
done
