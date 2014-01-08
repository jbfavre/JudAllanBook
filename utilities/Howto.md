# Génération du fichier epub

    FILE="../jud_allan-epub2.epub"
    rm -f "$FILE"
    zip -X0 "$FILE" mimetype
    zip -X9Dr "$FILE" META-INF images *.*

# Intégration d'images

Images chapitre   : 480px largeur
Images pleine-page: 480px hauteur
Images            : 360px au plus large

## Page de couverture

    <svg version="1.1" xmlns="http://www.w3.org/2000/svg"
         xmlns:xlink="http://www.w3.org/1999/xlink"
         width="100%" height="100%"
         viewBox="0 0 428 640"
         preserveAspectRatio="xMidYMid meet">
      <image width="428" height="640" xlink:href="cover-image.jpg" />
    </svg>

## Têtes de Chapitres:

    <h2 class="chapter">
      <span class="chapterHeader">
         <span class="translation">Chapitre</span>
         <span class="count">1</span>
      </span>
    La photographie magique</h2>
