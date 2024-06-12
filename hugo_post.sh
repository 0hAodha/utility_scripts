#!/bin/sh
# Simple script to create a new post in Hugo in the format "/content/posts/Post Title/index.md" as opposed to the default "/content/posts/Post Title.md"

title="$1"

mkdir "./content/posts/$title"
hugo new content "posts/$title/index.md"
