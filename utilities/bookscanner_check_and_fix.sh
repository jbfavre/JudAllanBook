#!/bin/bash

./utilities/bookscanner_typo_checker.sh $1
./utilities/bookscanner_typo_checker.sh -f $1
./utilities/bookscanner_typo_checker.sh $1

fold $1 -w 80 -s > /tmp/bookscanner.md
mv /tmp/bookscanner.md $1

git add $1

echo "You're now ready to commit $1 modifications"
