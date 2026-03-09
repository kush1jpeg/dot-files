#!/usr/bin/env sh

song=$(rmpc song | grep -oP '"file":"\K[^"]+')

[ -z "$song" ] && {
  notify-send -i ~/.config/rmpc/themes/logo.png "Failed Search" "No song playing"
  exit
}

song=${song%.mp3}

notify-send -i ~/.config/rmpc/themes/logo.png "YouTube Search" "Searching for $song"

xdg-open "https://www.youtube.com/results?search_query=$song"
