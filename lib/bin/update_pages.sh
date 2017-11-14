#!/bin/bash

DIR="$(cd "$(dirname "$0")" && pwd)"
rm -rf $DIR/../pages

git clone https://github.com/tldr-pages/tldr.git $DIR/../pages

rm -rf $DIR/../pages/*.md ; rm -rf $DIR/../pages/MAINTAINERS ; rm -rf $DIR/../pages/package.json ; rm -rf $DIR/../pages/screenshot.png ; rm -rf $DIR/../pages/scripts

mv $DIR/../pages/pages/* $DIR/../pages/

rm -rf $DIR/../pages/pages

mkdir $DIR/../pages/commonlinux

mv $DIR/../pages/common/* $DIR/../pages/commonlinux ; mv $DIR/../pages/linux/* $DIR/../pages/commonlinux

rm -rf $DIR/../pages/common ; rm -rf $DIR/../pages/linux

rm -rf $DIR/../pages/.git ; rm -rf $DIR/../pages/.github ; rm -rf $DIR/../pages/.gitignore ; rm -rf $DIR/../pages/.markdownlintrc ; rm -rf $DIR/../pages/.travis.yml ; rm -rf $DIR/../pages/.editorconfig

mkdir $DIR/../pages/otherpages

mv $DIR/../pages/osx $DIR/../pages/otherpages ; mv $DIR/../pages/sunos $DIR/../pages/otherpages ; mv $DIR/../pages/windows $DIR/../pages/otherpages

touch $DIR/../pages/commonlinux/.md
