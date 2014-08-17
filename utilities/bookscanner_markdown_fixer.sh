#!/bin/bash

function fix_markdown() {
  sed -i 's/ﬂ/fl/g' *.md
  sed -i 's/ﬁ/fi/g' *.md
  sed -i 's/ ?/ ?/g' *.md
  sed -i 's/ !/ !/g' *.md
  sed -i 's/ ;/ ;/g' *.md
  sed -i 's/ :/ :/g' *.md
  sed -i "s/'/’/g" *.md
  sed -i 's/‘/’/g' *.md
  sed -i 's/oe/œ/g' *.md
  sed -i 's/ae/æ/g' *.md
  sed -i 's/\.\.\./…/g' *.md
  sed -i 's/?\.\./?…/g' *.md
  sed -i 's/!\.\./!…/g' *.md
  sed -i 's/« /« /g' *.md
  sed -i 's/ »/ »/g' *.md
  sed -i 's/Mme /M^me^ /g' *.md
  sed -i 's/Mmes /M^mes^ /g' *.md
  sed -i 's/Mlle /M^lle^ /g' *.md
  sed -i 's/Mlles /M^lles^ /g' *.md
  sed -i 's/M. /M. /g' *.md
  sed -i 's/A /À /g' *.md

  sed -i 's/-/—/g' *.md
  sed -i 's/——/—/g' *.md

  sed -i 's/—/‐/g' *.md
}
function fix_text_width() {
  fold ../2-markdown_chapitres/*.md -w 80 -s
}



FIXTRIGGER=0
while getopts ":f" opt;
do
  case $opt in
    f)
      echo "Fix option has been triggered" >&2
      FIXTRIGGER=1
      ;;
    \?)
      echo "Invalid option -${OPTARG}" >&2
      ;;
  esac
  shift $(($OPTIND-1))
done
