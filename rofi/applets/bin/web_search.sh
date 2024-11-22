#!/usr/bin/env bash

dir="$HOME/.config/rofi/launchers/type-1"
theme='style-1'

# Define available search engines and their URLs
declare -A search_engines=(
  ["󰊭  g"]="https://www.google.com/search?q="
  ["󰇥  d"]="https://duckduckgo.com/?q="
  ["󰖬  w"]="https://en.wikipedia.org/wiki/Special:Search?search="
  ["󰗃  y"]="https://www.youtube.com/results?search_query="
  ["󰊿  en => pt"]="https://translate.google.com/?sl=en&tl=pt&op=translate&text="
  ["󰊿  pt => en"]="https://translate.google.com/?sl=pt&tl=en&op=translate&text="
)

# Prompt the user to select a search engine
# selected_engine=$(printf '%s\n' "${!search_engines[@]}" | rofi -dmenu -p "Select search engine:" -theme ${dir}/${theme}.rasi)
selected_engine=$(printf '%s\n' "${!search_engines[@]}" | rofi -dmenu -p "󰖟 " -theme ${dir}/${theme}.rasi)

# Exit if no search engine is selected
[ -z "$selected_engine" ] && exit

# Prompt the user for a search query
query=$(rofi -dmenu -p " " -theme ${dir}/${theme}.rasi)

# Exit if no query is entered
[ -z "$query" ] && exit

# Encode the query for URL compatibility
encoded_query=$(echo "$query" | jq -s -R -r @uri)

# Construct the search URL and open it in the default browser
xdg-open "${search_engines[$selected_engine]}$encoded_query"
