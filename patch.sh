#!/bin/bash

ApplyPatch ()
{
    # Change modified file to rename it to <base_name>_ROM
    sed -ri 's/(^rename to \w+)((.[A-Za-z])?)/\1_ROM\2/' $1
    sed -ri 's/(^[+]{3} b([/]{1})(\w+))/\1_ROM/g' $1

    # Apply
    env -i git apply $1
    echo "$1: correctly applied"
    exit 0
}

if [ $# -eq 1 ] 
then
    # Check if the patch exist and has write permissions
    if [ -w $1 ]
    then
        ApplyPatch $1
    else
        echo "Patchfile not found"
        exit 1
    fi
else
    echo "Incorrect use of the script."
    echo "Example:"
    echo "  patch <patch_file>"
fi

