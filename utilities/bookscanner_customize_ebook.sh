#!/bin/bash

NUMBER=1
for CHAPTER in $1/ch*.xhtml;
do
  sed -i "s|<h1>\(.*\)</h1>|<div class='chapterHeader'><span class='count'>${NUMBER}</span><h1 class='chapter'>\1</h1></div>|g" ${CHAPTER}
  ((NUMBER++))
done

WIDTH=$(convert $1/cover-image.jpg -print "%w\n" /dev/null)
HEIGHT=$(convert $1/cover-image.jpg -print "%h\n" /dev/null)
sed -i "s|<div.*|<svg version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='100%' height='100%' viewBox='0 0 ${WIDTH} ${HEIGHT}' preserveAspectRatio='xMidYMid meet'><image width='${WIDTH}' height='${HEIGHT}' xlink:href='cover-image.jpg' /></svg>|g;s|<img.*||g;s|</div>||g" $1/cover.xhtml

sed -i 's|<itemref idref="title_page_xhtml" linear="no" />|<itemref idref="title_page_xhtml" linear="yes" />|g' $1/content.opf
sed -i 's|<item id="cover_xhtml" href="cover.xhtml" media-type="application/xhtml+xml" />|<item id="cover_xhtml" href="cover.xhtml" media-type="application/xhtml+xml" properties="svg" />|g' $1/content.opf
