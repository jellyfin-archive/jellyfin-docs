#!/bin/bash

# clone website
git clone https://github.com/jellyfin/jellyfin.github.io
pushd jellyfin.github.io

# remove old docs
rm -rf docs
mkdir -p docs
popd

# update docs
unzip *.zip -d jellyfin.github.io/docs

# commit new changes
git add docs
git commit -m 'azure update docs'
git push origin

# remove repository files
rm -rf jellyfin.github.io