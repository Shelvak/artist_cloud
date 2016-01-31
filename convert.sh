#!/bin/sh

SED_COMMAND='sed'
if test "$(uname)" = "Darwin"; then
  SED_COMMAND='gsed'
fi


read -p "Converting ArtistCloud (mayus) in: " choice
egrep -rl 'ArtistCloud' * | xargs $SED_COMMAND -i "s/ArtistCloud/$choice/g"

read -p "Converting artist_cloud (minus) in: " choice
egrep -rl 'artist_cloud' . | xargs $SED_COMMAND -i "s/artist_cloud/$choice/g"
