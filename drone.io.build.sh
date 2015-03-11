#!/bin/sh
set -x
set -e

# display some debug logs (please disable to hide your sensitive credentials!)
pwd
env

# check if we're running a Drone.io or a local build
if [ "x$GH_TOKEN" == "x" ]; then
  DRONE_BUILD="N"
else
  DRONE_BUILD="Y"
fi

# detect if we are running from a master or a dev branch
#GH_MASTER=Y


# fetch hugo and show version in build log
if [ "x$DRONE_BUILD" == "xY" ]; then
  go get -u -v github.com/spf13/hugo
fi
hugo version

# build the static web content
cd ./hugo-website
if [ "x$GH_MASTER" == "xY" ]; then
  # build production posts only
  hugo --theme=hugo-uno
else
  # build including all draft posts
  hugo --theme=hugo-uno --buildDrafts
fi

# push the static web content to gh-pages
if [ "x$DRONE_BUILD" == "xY" ]; then
  echo "...push it"
else
  echo "...local, don't push"
fi
