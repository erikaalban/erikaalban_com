#! /usr/bin/env bash

for file in index.html styles.css script.js profile.jpg; do
    aws s3 cp $file s3://erikaalban.com/${file}
done
