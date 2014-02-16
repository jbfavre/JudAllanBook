# Jud Allan

Ce dépôt accueille le travail de reconstitution du livre « Jud Allan »
de Paul d'Ivoi.

Cet ouvrage, qui est dans le domaine public, a été numérisé dans le local
de [La Quadrature du Net](1) le 26 octobre 2013 à l'aide du book scanner.

Compte tenu de leur taille & nombre, les photos résultants de l'opération
de numérisation seront prochainement disponibles sur les réseaux P2P.

## Le livre

« Jud Allan, roi des _lads_ » a été écrit par [Paul d'Ivoi](2)
en 1909. Il fait partie des [Voyages excentriques](3)
qui comptent 21 volumes.

L'édition qui a été utilisée pour la numérisation date de 1932. Elle a
été publiée par les éditions « Boivin et Cie » à Paris.

## Post-production

Vous pouvez, si vous le souhaitez, participer au travail de post-production.
Pour cela, il vous suffit de:

* ouvrir un compte sur GitHub
* forker ce dépôt
* récupérer les images (lien à venir)
  - corriger les erreurs du logiciel de reconnaissance de caractères
  - extraire les gravures des photos pour pouvoir, à terme, les réintégrer
    dans l'ouvrage final

## Syntaxe Markdown

Le texte corrigé doit être formaté avec Markdown. Ceci simplifiera les
opérations de conversion dans les formats Epub, PDF Texte, HTML, ...

### Largeur de texte

Pour faciliter le travail en « demi-écran », avec l'image d'un côté et
le texte de l'autre, le texte doit être coupé à 80 caractères environ. Les
mots ne doivent **jamais** être coupés. Un simple retour à la ligne est
utilisé pour indiquer que le paragraphe n'est pas terminé. Par exemple:

    Pour faciliter le travail en « demi-écran », avec l'image d'un côté et
    le texte de l'autre, le texte sera coupé à 80 caractères environ. Les
    mots ne doivent **jamais** être coupés. Un simple retour à la ligne est
    utilisé pour indiquer que le paragraphe n'est pas terminé. Par exemple:

### Paragraphes

Les paragraphes quant à eux sont matérialisés par une ligne vide.

Par exemple, voici ce que cela donne:

    Les paragraphes sont matérialisés par une ligne vide.
    >>> ligne vide
    Par exemple, voici ce que cela donne:

### Mise en évidence du texte

Un texte italique est encadré de deux _traits soulignés_ (tiret bas du 8) comme ceci:

    Un texte italique est encadré de deux _traits soulignés_ (tiret bas du 8) comme
    ceci:

Un texte en gras est, lui, précédé et suivi de 2 **étoiles**, comme par exemple:

    Un texte en gras est, lui, précédé et suivi de 2 **étoiles**, comme par
    exemple:

Il est bien sûr **_possible_** de _**mélanger les 2**_:

    Il est bien sûr **_possible_** de _**mélanger les 2**_:

### Citations

> Les citations débutent par le signe > suivi d'une espace. Il n'est pas
  nécessaire d'ajouter le signe > à chaque ligne.

> En revanche, il faut le remettre à chaque paragraphe.

    > Les citations débutent par le signe > suivi d'une espace. Il n'est pas
      nécessaire d'ajouter le signe > à chaque ligne.
    
    > En revanche, il faut le remettre à chaque paragraphe.

## Conventions typographiques

### Caractères Unicode

Les caractères unicode tels que `U+2014` peuvent être obtenus de la manière
suivante (testé sur un ordinateur portable sous Linux):

#### Sous Linux

1. Tapez `CTRL + SHIFT + u` et relâchez (Vous obtenez <u>`u`</u> à l'affichage)
2. Tapez le code `2014`

#### Sous Windows

1. Tapez `Alt` et maintenez la touche enfoncée
2. Tapez le code `2014`

### Tirets

Les dialogues sont précédés d'un tiret cadratin —, code `U+2014` ( et **pas**
d'un trait d'union). Le tiret cadratin est plus large que le trait d'union 
(ou « tiret du 6 »), code `U+002D`.

    — tiret cadratin `U+2014`
    – tiret d'incise `U+2013`
    - trait d'union `U+2010`

Le tiret cadratin est, entre autre, utilisé en incise. Il est alors
accompagné d'une espace justifiante à l'extérieur et d'une espace insécable
à l'intérieur.
Par exemple, ce – texte d'incise – s'écrit:

    `U+00A0``U+2013``U+00A0`texte d'incise`U+00A0``U+2013``U+00A0`

[Tiret sur Wikipédia](4)

### Guillemets & apostrophes

Les guillemets français «, code `U+00AB`, et », code  `U+00BB`, précédés ou
suivi d’espaces insécables, doivent être préférés à leur équivalent anglais
“, code `U+201C` et ”, code `U+201D`, sauf utilisation explicite dans l'édition
numérisée. Dans ce cas, on veillera à ne jamais inclure d'espace.

La version informatique " ne doit jamais être utilisée.

En ce qui concerne les guillemets imbriqués, on peut parfois les remplacer par de
l’italique, notamment pour noter un mot d’une langue étrangère. Ainsi, on écrira : « Jud Allan, roi des _lads_ » plutôt que « Jud Allan, roi des “lads” ».

Enfin, pour les apostrophes, la version informatique ' doit également 
être bannie, au profit de ’, code `U+2019`.

Il existe également ‘, code `U+2018` mais on préférera en général la première.

[Guillemet sur Wikipédia](5)

### Points de suspension

Les point de suspension peuvent être obtenus en utilisant le code `U+2026`

### Espaces, espaces justifiantes & espaces insécables

L'espace justifiante, code `U+2003`, est utilisée dans les textes d'incise,
à l'extérieur du tiret cadratin.

En outre, il existe deux types d'espaces insécables:

1. les espaces fines, code `U+202F`
2. les espaces pleines, code `U+00A0`

Elles sont utilisées afin d'éviter des retour à la ligne intempestifs, par
exemple avant (ou après dans le cas du guillemet ouvrant français) les signes de
ponctuation suivants:

    ? ! ; : « »

En général, on préférera les espaces fines, sauf avant les signes : ou les guillemets où les 2 sont acceptées.

[1]: http://www.laquadrature.net/fr
[2]: https://fr.wikipedia.org/wiki/Paul_d%27Ivoi
[3]: https://fr.wikipedia.org/wiki/Paul_d%27Ivoi#Les_Voyages_excentriques
[4]: http://fr.wikipedia.org/wiki/Tiret
[5]: http://fr.wikipedia.org/wiki/Guillemets

