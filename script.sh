#!/bin/sh
cat temp.txt | while read line; do
    new=$(echo $line | sed 's/.\/input/.\/output/g' | sed 's/.xhtml/.gmi/g;s/.html/.gmi/g;s/.htm/.gmi/g')
    ./html2gmi -i $line -o $new -mne
done

