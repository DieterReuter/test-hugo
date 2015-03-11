#!/bin/sh
set -x
set -e

go get -u -v github.com/spf13/hugo
hugo version

pwd
env

cd ./hugo-website
hugo --theme=hugo-uno --buildDrafts
ls -alR ./public
