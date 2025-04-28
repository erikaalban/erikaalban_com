#! /usr/bin/env bash

for file in $(ls assets/*); do
    filename=$(basename $file)
    aws s3 cp $file s3://erikaalban.com/${filename}
done
