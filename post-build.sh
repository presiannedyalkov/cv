#!/bin/bash

# inject css from assets css main.css into head <style> and remove link
html='_site/index.html'
# get css
read -r css<'_site/assets/css/main.css'
# write css in index.html
sed -i "s/<\/title>/<\/title>\n<style>$css<\/style>/" $html
# delete css reference
sed -i "s/.*main\.css.*//" $html

# inject javascript on place where the file is called. minify in single js to include
match='<script src="https:\/\/presiannedyalkov.github.io\/cv\/assets\/javascript\/toggleDark.js">'
sed -i "s/$match/\n<script>insert_script\n/" $html
sed -i "/insert_script/r _site/assets/javascript/toggleDark.js" $html
sed -i "s/ src=\"https\:\/\/presiannedyalkov\.github\.io\/cv\/assets\/javascript\/toggleDark\.js\"//" $html
sed -i "s/insert_script//" $html

# minify file
npx --yes html-minifier --input-dir _site --output-dir _site --file-ext html --collapse-whitespace --remove-comments --minify-js true
# create url for unzip.ninja with zipped file string in hash
zip=$(cat _site/index.html | gzip | base64 -w0)
# add link to readme
title=$(grep -oP '(?<=<title>).*(?=<\/title>)' _site/index.html | sed "s/ /_/g")
link=$(echo 'http://www.unzip.ninja#'$title'/'$zip)
echo $link