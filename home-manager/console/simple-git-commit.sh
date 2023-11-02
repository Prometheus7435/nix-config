#!/bin/bash

echo -en "Enter commit message:  "
read COMMIT_MESSAGE

echo ${COMMIT_MESSAGE}

pushd ${HOME}/Zero/nix-config

git add .

git commit -m "${COMMIT_MESSAGE}"

git push

popd
