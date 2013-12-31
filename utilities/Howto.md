#!/bin/bash
FILE="../jud_allan-epub3.epub"
rm -f "$FILE"
zip -X0 "$FILE" mimetype
zip -X9Dr "$FILE" META-INF images *.*

Intégration d'images

<svg version="1.1" xmlns="http://www.w3.org/2000/svg"
     xmlns:xlink="http://www.w3.org/1999/xlink"
     width="100%" height="100%"
     viewBox="0 0 428 640"
     preserveAspectRatio="xMidYMid meet">
  <image width="428" height="640" xlink:href="cover-image.jpg" />
</svg>



Images chapitre   : 480 largeur
Images pleine-page: 480 hauteur
Images            : 360 hauteur
