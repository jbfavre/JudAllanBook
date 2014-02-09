# Génération du fichier epub

Pour la partie 1

    FILE="../output/Jud_Allan-part-1.epub"
    rm -f "$FILE"
    zip -X0 "$FILE" mimetype
    zip -X9Dr "$FILE" META-INF images *.*

Ou pour la partie 2

    FILE="../output/Jud_Allan-part-2.epub"
    rm -f "$FILE"
    zip -X0 "$FILE" mimetype
    zip -X9Dr "$FILE" META-INF images *.*

# Intégration d'images

- Extraire les images des photos originales (avant traitement pas ScanTailor ou autre)
- Convertir les images en "nuances de gris"
- Exporter au format.jpg, qualité 90
- Redimensionner les images avec le script:

        SIZE=480
        for file in *.jpg; do
           echo -n Converting ${file}...
          convert -resize ${SIZE}x${SIZE} -quality 60 "$file" "little/${file%.*}.jpg"
           echo done
        done

## Page de couverture

    <svg version="1.1" xmlns="http://www.w3.org/2000/svg"
         xmlns:xlink="http://www.w3.org/1999/xlink"
         width="100%" height="100%"
         viewBox="0 0 428 640"
         preserveAspectRatio="xMidYMid meet">
      <image width="428" height="640" xlink:href="cover-image.jpg" />
    </svg>

## Têtes de Chapitres:

<h2 class="chapter"><span class="chapterHeader"><span class="translation">Chapitre</span><span class="count">1</span></span>
La photographie magique</h2>


## Typo autoFixer

    sed -i 's/ﬂ/fl/g' 2-markdown_chapitres/2-part-1-*.md
    sed -i 's/ﬁ/fi/g' 2-markdown_chapitres/2-part-1-*.md
    sed -i 's/ ?/ ?/g' 2-markdown_chapitres/2-part-1-*.md
    sed -i 's/ !/ !/g' 2-markdown_chapitres/2-part-1-*.md
    sed -i 's/ ;/ ;/g' 2-markdown_chapitres/2-part-1-*.md
    sed -i 's/ :/ :/g' 2-markdown_chapitres/2-part-1-*.md
    sed -i "s/'/’/g" 2-markdown_chapitres/2-part-1-*.md
    sed -i 's/‘/’/g' 2-markdown_chapitres/2-part-1-*.md
    sed -i 's/oe/œ/g' 2-markdown_chapitres/2-part-1-*.md
    sed -i 's/ae/æ/g' 2-markdown_chapitres/2-part-1-*.md
    sed -i 's/\.\.\./…/g' 2-markdown_chapitres/2-part-1-*.md
    sed -i 's/?\.\./?…/g' 2-markdown_chapitres/2-part-1-*.md
    sed -i 's/!\.\./!…/g' 2-markdown_chapitres/2-part-1-*.md
    sed -i 's/« /« /g' 2-markdown_chapitres/2-part-1-*.md
    sed -i 's/ »/ »/g' 2-markdown_chapitres/2-part-1-*.md
    sed -i 's/Mme /M^me /g' 2-markdown_chapitres/2-part-1-*.md
    sed -i 's/Mmes /M^mes /g' 2-markdown_chapitres/2-part-1-*.md
    sed -i 's/Mlle /M^lle /g' 2-markdown_chapitres/2-part-1-*.md
    sed -i 's/Mlles /M^lles /g' 2-markdown_chapitres/2-part-1-*.md
    sed -i 's/M\. /M\. /g' 2-markdown_chapitres/2-part-1-*.md
    sed -i 's/ A / À /g' 2-markdown_chapitres/2-part-1-*.md
