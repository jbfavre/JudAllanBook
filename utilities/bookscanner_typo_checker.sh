#!/bin/bash

nnbs=' '  # U+202F
nbs=' '   # U+00A0
space=' ' # space

check_ok_before="\e[32m"
check_nok_before="\e[31m"
check_after="\e[0m"

function check_typo() {

  typo=$1
  space_place=$2
  space_type=$3

  nb_typo=$(grep "${typo}" ${FILE} | grep -v "$typo\["|wc -l)
  echo "Checking ${nb_typo} \"${typo}\": "

  if [ ${nb_typo} -ne 0 ];
  then

    search_pattern="${nnbs}${typo}"
    if [ "${space_place}" == "after" ]
    then
      search_pattern="${typo}${nnbs}"
    fi
    nb_nnbs=$(grep "${search_pattern}" ${FILE}|wc -l)
    [ ${nb_nnbs} -gt 0 -a "${space_type}"="nnbs" -o \
      ${nb_nnbs} -eq 0 -a !"${space_type}"="nnbs" ] || \
      echo -e "${check_nok_before}Narrow No-Break Space ${nb_nnbs}${check_after}"

    search_pattern="${nbs}${typo}"
    if [ "${space_place}" == "after" ]
    then
      search_pattern="${typo}${nbs}"
    fi
    nb_nbs=$(grep "${search_pattern}" ${FILE}|wc -l)
    [ ${nb_nbs} -gt 0 -a "${space_type}"="nbs" -o \
      ${nb_nbs} -eq 0 -a !"${space_type}"="nbs" ] || \
      echo -e "${check_nok_before}No-Break Space ${nb_nbs}${check_after}"

    search_pattern=" ${typo}"
    if [ "${space_place}" == "after" ]
    then
      search_pattern="${typo} "
    fi
    nb_space=$(grep "${search_pattern}" ${FILE}|wc -l)
    [ ${nb_space} -gt 0 ] && \
      (echo -e "${check_nok_before}Space ${nb_space}${check_after}")
  fi
}

function fix_typo() {

  echo "Fixing ';'"
  egrep -q '[   ]{0,};' ${FILE} && \
    sed -i 's/[   ]\{0,\};/ ;/g' ${FILE}

  echo "Fixing '?'"
  egrep -q '[   ]{0,}\?' ${FILE} && \
    sed -i 's/[   ]\{0,\}?/ ?/g' ${FILE}

  echo "Fixing '!'"
  egrep -q '[   ]{0,}!' ${FILE} && \
    sed -i 's/[   ]\{0,\}!/ !/g' ${FILE}

  echo "Fixing '«'"
  egrep -q '«[   ]{0,}' ${FILE} && \
    sed -i 's/«[   ]\{0,\}/« /g' ${FILE}

  echo "Fixing '»'"
  egrep -q '[   ]{0,}»' ${FILE} && \
    sed -i 's/[   ]\{0,\}»/ »/g' ${FILE}

  echo "Fixing ':'"
  egrep -q '[   ]{0,}:' ${FILE} && \
    sed -i 's/[   ]\{0,\}:/ :/g' ${FILE}

  echo "Fixing markdown images"
    sed -i 's/^[   ]\{1,\}!\[/\!\[/g' ${FILE}

  echo "Fixing dialogs"
    sed -i 's/^-[   ]\{0,\}/— /g' ${FILE}

  echo "Fixing quotes"
    sed -i "s/'/’/g" ${FILE}
    sed -i 's/‘/’/g' ${FILE}

  echo "Fixing ligatures"
    sed -i 's/ﬂ/fl/g' ${FILE}
    sed -i 's/ﬁ/fi/g' ${FILE}
    sed -i 's/oe/œ/g' ${FILE}
    sed -i 's/ae/æ/g' ${FILE}

  echo "Fixing Markdown"
    sed -i 's/Mme[   ]\{1,\}/M^me^ /g' ${FILE}
    sed -i 's/Mmes[   ]\{1,\}/M^mes^ /g' ${FILE}
    sed -i 's/Mlle[   ]\{1,\}/M^lle^ /g' ${FILE}
    sed -i 's/Mlles[   ]\{1,\}/M^lles^ /g' ${FILE}
    sed -i 's/M\.[   ]\{1,\}/M\. /g' ${FILE}

  echo "Other classical typographic fixes"
    sed -i 's/A /À /g' ${FILE}
    sed -i 's/\.\.\./…/g' ${FILE}


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

# ;   -> "Narrow No-Break Space" before
# ?   -> "Narrow No-Break Space" before
# !   -> "Narrow No-Break Space" before
# «   -> "Narrow No-Break Space" after
# »   -> "Narrow No-Break Space" before
# :   ->        "No-Break Space" before
# ... ->                  "None" none
for FILE in $@;
do
  if [ -e ${FILE} ]
  then
    echo "Checking ${FILE} "
    echo $(check_typo ";" "before" "nnbs")
    echo $(check_typo "?" "before" "nnbs")
    echo $(check_typo "!" "before" "nnbs")
    echo $(check_typo "«" "after"  "nnbs")
    echo $(check_typo "»" "before" "nnbs")
    echo $(check_typo ":" "before" "nbs")
    echo $(check_typo '"' "before" "none")
 fi
 [ ${FIXTRIGGER} -eq 1 ] && fix_typo
done
