#!/bin/bash

# Download the latest release
curl -s https://api.github.com/repos/jellyfin/jellyfin-docs/releases/latest | grep "browser_download_url.*docs-.*\.tar\.gz" | cut -d : -f 2,3 | tr -d \" | wget -O /tmp/docs.tar.gz -qi -

# Clean any old files
rm -rf docs/

mkdir -p docs/
pushd docs

# Extract the files
tar -xzf /tmp/docs.tar.gz
popd

git add docs/
git commit -m "CI Documentation update"
git push origin