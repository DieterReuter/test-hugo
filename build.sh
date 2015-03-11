#!/bin/bash
set -x
set -e

# pull all themes
git submodule foreach git pull

## display some debug logs (please disable to hide your sensitive credentials!)
#pwd
#env

# fetch hugo and show version in build log
if [ "$DRONE" == "true" ]; then
  go get -u -v github.com/spf13/hugo
fi
hugo version

# build the static web content
cd ./hugo-website
rm -fr ./public
for i in $(find . -type d -regex ``./[^.].*'' -empty); do touch $i"/.gitignore"; done;
if [ "$DRONE_BRANCH" == "xxxmaster" ]; then
  # build production posts only
  hugo --theme=hugo-uno
else
  # build including all draft posts
  hugo --theme=hugo-uno --buildDrafts
fi

# push the static web content to gh-pages
if [ "$DRONE" == "true" ]; then
  echo "...push it"
  ../deploy.sh
else
  echo "...local, don't push"
  open http://localhost:1313/
  hugo server --theme=hugo-uno --buildDrafts
fi
