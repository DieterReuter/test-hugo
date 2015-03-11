#!/bin/sh 
set -x
set -e

go get -u -v github.com/spf13/hugo
hugo version

pwd
ls -alR .

