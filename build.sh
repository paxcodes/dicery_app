#!/bin/bash

# I have to set flutter channel to beta for `web` to be supported
# https://flutter.dev/docs/get-started/web accessed on 2021-Jan-09
FLUTTER_BRANCH=beta

# Get flutter
git clone https://github.com/flutter/flutter.git
FLUTTER=flutter/bin/flutter

# Flutter channel cmd
cmd="${FLUTTER} channel ${FLUTTER_BRANCH}"

# Set channel info and update
DIR=$($cmd >& /dev/stdout)
echo "<!-- $DIR -->"
$FLUTTER config --enable-web
if [[ $DIR == *"Your branch is behind"* ]]; then
  echo "Update starting"
  $FLUTTER upgrade
  echo "Update finished"
fi

# Build flutter for web
$FLUTTER build web --release
