#! /bin/bash

#
echo "Create build"
flutter build web --base-href /Interesting/ --release

echo "clean empty docs folder"
rm -r ../docs/*

echo "copy build to docs"
cp -r build/web/* ../docs/

echo "Don't forget to commit and push to main"