#!/bin/bash

function do_convert() {
   local file=$1
   echo -n Converting ${file}...
   convert -resize ${SIZE}x${SIZE} -quality 60 "${file}" "images/$(basename ${file})"
   echo done
}

SIZE=480
for file in raw_images/page*.jpg; do
    do_convert ${file}
done
SIZE=800
for file in raw_images/cover*.jpg; do
    do_convert ${file}
done
