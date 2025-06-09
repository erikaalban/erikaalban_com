#! /usr/bin/env bash

for file in $(ls assets/*); do
    filename=$(basename $file)
    
    # Set cache control headers based on file type
    if [[ $filename == *.css ]] || [[ $filename == *.js ]]; then
        # CSS and JS files - short cache with must-revalidate
        aws s3 cp $file s3://erikaalban.com/${filename} --cache-control "max-age=300, must-revalidate"
    elif [[ $filename == *.html ]]; then
        # HTML files - no cache
        aws s3 cp $file s3://erikaalban.com/${filename} --cache-control "no-cache, no-store, must-revalidate"
    else
        # Images and other assets - longer cache
        aws s3 cp $file s3://erikaalban.com/${filename} --cache-control "max-age=86400"
    fi
done
