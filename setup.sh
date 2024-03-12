#!/bin/bash

TARGET_DIR="$HOME"

if [ ! -d ".git" ]; then
    echo "Error: Run this script from the .dotfiles directory"
    exit 1
fi

for file in *; do
    if [ -f "$file" ]; then
        if [ -e "TARGET_DIR/$file" ]; then
            echo "$file already exists in your home directory."
            read -p "Overwrite $file in home directory? (y/n) " -n 1 -r choice 
            echo
            if [[ $choice =~ ^[Yy]$ ]]; then
                rm -i "$TARGET_DIR/$file"
                ln -s "$PWD/$file" "$TARGET_DIR/$file"
                echo "Created symlink for $file"
            fi
        else
            ln -s "$PWD/$file" "$TARGET_DIR/$file"
            echo "Created symlink for $file"
        fi
    fi
done