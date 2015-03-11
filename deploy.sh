#!/bin/bash
set -x
set -o errexit -o nounset

cd ./public

git init
git config user.name "Dieter Reuter"
git config user.email "dieter.reuter@me.com"

git remote add upstream "https://$GH_TOKEN@github.com/dieterreuter/dieterreuter.github.io.git"
git fetch upstream
git reset upstream/master

git add -A .
git commit -m "Drone.io build #${DRONE_BUILD_ID}, at ${GIT_COMMIT}"
git push -q upstream HEAD:master
