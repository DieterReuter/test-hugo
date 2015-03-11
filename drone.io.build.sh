#!/bin/sh
set -x
set -e

# display some debug logs (please disable to hide your sensitive credentials!)
pwd
env


# fetch hugo and show version in build log
if [ "$DRONE" == "true" ]; then
  go get -u -v github.com/spf13/hugo
fi
hugo version

# build the static web content
cd ./hugo-website
if [ "$DRONE_BRANCH" == "master" ]; then
  # build production posts only
  hugo --theme=hugo-uno
else
  # build including all draft posts
  hugo --theme=hugo-uno --buildDrafts
fi

# push the static web content to gh-pages
if [ "$DRONE" == "true" ]; then
  echo "...push it"
else
  echo "...local, don't push"
fi
