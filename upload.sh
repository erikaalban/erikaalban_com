#! /usr/bin/env bash

for file in $(ls assets/*); do
    aws s3 cp $file s3://erikaalban.com/${file}
done
