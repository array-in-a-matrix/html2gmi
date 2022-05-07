#!/bin/sh
# convert html content to gmi
cat temp.txt | while read line; do
    new=$(echo $line | sed 's/.\/input/.\/output/g' | sed 's/.xhtml/.gmi/g;s/.html/.gmi/g;s/.htm/.gmi/g')
    ./html2gmi -i $line -o $new #-mne
done

# replace .html extensions with .gmi in each file
filepath="output"
searchstring=".html"
replacestring=".gmi"

i=0; 

for file in $(grep -l -R $searchstring $filepath)
do
  cp $file $file.bak
  sed -e "s/$searchstring/$replacestring/ig" $file > tempfile.tmp
  mv tempfile.tmp $file

  let i++;

  echo "Modified: " $file
done

