#!/bin/bash

# clone website
git clone https://github.com/jellyfin/jellyfin.github.io

# update docs
unzip *.zip
cp -rf _site/* jellyfin.github.io/docs

# move to git directory
cd jellyfin.github.io
git add .

# commit new changes
git -c "user.name=jellyfin-bot" -c "user.email=team@jellyfin.org" commit -m "Azure Update Docs ${BUILD_BUILDID}"

# add repository
git remote add ssh git@github.com:jellyfin/jellyfin.github.io.git

# push changes
export GIT_SSH_COMMAND="ssh -i ${BOT_SECUREFILEPATH}"
git -c "user.name=jellyfin-bot" -c "user.email=team@jellyfin.org" push ssh
