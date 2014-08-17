#!/bin/bash

ROOT=$(pwd)

FILE="$2"

cd $1
rm -f "$FILE"
zip -q -X0 "$FILE" mimetype
zip -q -X9Dr "$FILE" META-INF media *.*

cd ${ROOT}
