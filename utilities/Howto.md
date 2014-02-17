# Préparation

La numérisation achevée, les pages sont réparties dans les répertoires `left` et
`right` et les images nommées par l'appareil photo.  
Il faut tout d'abord reconstituer le livre en renommant les pages et en les
rassemblant.

La numérotation des fichiers doit respecter la numérotation physique.
Les photos des pages de couverture seront donc appelées `cover-*.JPG`
et les pages `page-*.JPG`

Les pages de gauche porteront donc les numéros impairs, les pages de droite les
numéros pairs.

Pour les pages de gauche on utilisera:

        PAGE=1
        for file in IMG_*.JPG;
        do
            mv ${file} page-${PAGE}.JPG
            PAGE=$((PAGE+2))
        done

Et pour les pages de droite:

        PAGE=2
        for file in IMG_*.JPG;
        do
            mv ${file} page-${PAGE}.JPG
            PAGE=$((PAGE+2))
        done

Une fois les pages renumérotées et rassemblées, il faut encore leur appliquer
une rotation de 90° vers la droite pour les pages impaires et vers la gauche
pour les pages paires.
Ceci est équivalent à une rotation de 90° vers la droite pour les pages impaires
et de 270° vers la droite pour les pages paires, ce que réalise la bout de script
suivant:

        for file in page-*.JPG;
        do
            PAGE=${file#page-*}
            PAGE=${PAGE%.JPG}
            MODULO=$((PAGE % 2))
            ROTATE=$((270-MODULO*180))
            convert -rotate ${ROTATE} ${file} ${file%.*}.jpg
            mv ${file%.*}.jpg ${file}
        done

# Traitement du texte

## Reconnaissance de caractères

## Correction automatique

Parfois, le logiciel de reconnaissance de caractères utilise des
combinaisons particulières, par exemple: « ﬁ » (en un seul caractère) au
lieu de « fi » (en deux caractères)

Les commandes suivantes peuvent vous aider à effectuer le remplacement plus
rapidement :

        sed -i 's/ﬂ/fl/g' 2-markdown_chapitres/part-*/*.md
        sed -i 's/ﬁ/fi/g' 2-markdown_chapitres/part-*/*.md
        sed -i 's/ ?/ ?/g' 2-markdown_chapitres/part-*/*.md
        sed -i 's/ !/ !/g' 2-markdown_chapitres/part-*/*.md
        sed -i 's/ ;/ ;/g' 2-markdown_chapitres/part-*/*.md
        sed -i 's/ :/ :/g' 2-markdown_chapitres/part-*/*.md
        sed -i "s/'/’/g" 2-markdown_chapitres/part-*/*.md
        sed -i 's/‘/’/g' 2-markdown_chapitres/part-*/*.md
        sed -i 's/oe/œ/g' 2-markdown_chapitres/part-*/*.md
        sed -i 's/ae/æ/g' 2-markdown_chapitres/part-*/*.md
        sed -i 's/\.\.\./…/g' 2-markdown_chapitres/part-*/*.md
        sed -i 's/?\.\./?…/g' 2-markdown_chapitres/part-*/*.md
        sed -i 's/!\.\./!…/g' 2-markdown_chapitres/part-*/*.md
        sed -i 's/« /« /g' 2-markdown_chapitres/part-*/*.md
        sed -i 's/ »/ »/g' 2-markdown_chapitres/part-*/*.md
        sed -i 's/Mme /M^me^ /g' 2-markdown_chapitres/part-*/*.md
        sed -i 's/Mmes /M^mes^ /g' 2-markdown_chapitres/part-*/*.md
        sed -i 's/Mlle /M^lle^ /g' 2-markdown_chapitres/part-*/*.md
        sed -i 's/Mlles /M^lles^ /g' 2-markdown_chapitres/part-*/*.md
        sed -i 's/M\. /M\. /g' 2-markdown_chapitres/part-*/*.md
        sed -i 's/A /À /g' 2-markdown_chapitres/part-*/*.md

Attention, n'exécutez ces commandes que sur une page **corrigéé** pour limiter
au maximum les effets de bord.

# Traitement des images

- Extraire les images des photos originales (avant
  traitement par ScanTailor ou autre)
- Convertir les images en "nuances de gris"
- Exporter au format.jpg, qualité 90
- Redimensionner les images avec le script:

        SIZE=480
        for file in *.JPG; do
           echo -n Converting ${file}...
          convert -resize ${SIZE}x${SIZE} -quality 60 "$file" "little/${file%.*}.jpg"
           echo done
        done

# Post-production de l'epub

## Page de couverture

Par défaut, l'image de couverture est dans une simple balise `img`
Pour Jud Allan, j'ai choisi le code suivant, plus universel:

    <svg version="1.1" xmlns="http://www.w3.org/2000/svg"
         xmlns:xlink="http://www.w3.org/1999/xlink"
         width="100%" height="100%"
         viewBox="0 0 428 640"
         preserveAspectRatio="xMidYMid meet">
      <image width="428" height="640" xlink:href="cover-image.jpg" />
    </svg>

## Têtes de Chapitres

Pandoc ne permet malheureusement pas de personnaliser la sortie HTML.  
Pour Jud Allan, j'ai choisi de remplacer toute les occurrences de:

         class="section level2"><h2>

par
         class="section level2"><h2 class="chapter"><span class="chapterHeader"><span class="translation">Chapitre</span><span class="count">1</span></span>

Le numéro de chapitre est ensuite manuellement corrigé.

Pour passer avec succès les tests de epubcheck, il faut également modifier les
images de têtes de chapitre: la norme impose l'élément alt, mais pandoc en
profite pour ajouter un titre. Il faut donc ôter le titre en remplaçant:

        alt="Chapitre (\d)+" /><p class="caption">Chapitre \d+</p>

par

        alt="Chapitre" />


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

