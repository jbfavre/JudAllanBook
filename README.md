# Jud Allan

Ce dépôt accueille le travail de reconstitution du livre "Jud Allan" de Paul
d'Ivoi.

Cet ouvrage, qui est dans le domaine public, a été numérisé dans le local de
[La Quadrature du Net](1) le 26 octobre 2013 à
l'aide du book scanner.

Compte tenu de leur taille & nombre, les photos résultants de l'opération de
numérisation seront prochainement disponibles sur les réseaux P2P.

## Le livre

"Jud Allan, roi des « lads »" a été écrit par [Paul d'Ivoi](2)
en 1909. Il fait partie des [Voyages excentriques](3)
qui comptent 21 volumes

L'édition qui a été utilisée pour la numérisation date de 1932. Elle a été
éditée par les éditions "Boivin et Cie" à Paris.

## Post-production

Vous pouvez, si vous le souhaitez, participer au travail de post-production. Pour
cela, il vous suffit de:

* ouvrir un compte sur GitHub
* forker ce dépôt
* récupérer les images (lien à venir)
  - corriger les erreurs du logiciel de reconnaissance de caractères
  - extraire les gravures des photos pour pouvoir, à terme, les réintégrer dans
    l'ouvrage final

## Syntaxe Markdown

Le texte corrigé doit être formaté avec Markdown. Ceci simplifiera les opérations
de conversion dans les formats Epub, PDF Texte, HTML, ...

### Largeur de texte

Pour faciliter le travail en "demi-écran", avec l'image d'un côté et
le texte de l'autre, le texte sera coupé à 80 caractères environ. Les
mots ne doivent **jamais** être coupés. Un simple retour à la ligne est
utilisé pour indiqué que le paragraphe n'est pas terminé. Par exemple:

    Pour faciliter le travail en "demi-écran", avec l'image d'un côté et
    le texte de l'autre, le texte sera coupé à 80 caractères environ. Les
    mots ne doivent **jamais** être coupés. Un simple retour à la ligne est
    utilisé pour indiqué que le paragraphe n'est pas terminé. Par exemple:

### Paragraphes

Les paragraphes sont matérialisés par une ligne vide.

Par exemple, voici ce que cela donne:

    Les paragraphes sont matérialisés par une ligne vide.
    >>> ligne vide
    Par exemple, voici ce que cela donne:

### Mise en évidence du texte

Un texte italique est encadré de 2 _underscore_ comme ceci:

    Un texte italique est encadré de 2 _underscore_ comme ceci:

Un texte en gras est, lui, encadré de 2 **étoiles**, comme par exemple:

    Un texte en gras est, lui, encadré de 2 **étoiles**, comme par exemple:

### Citations

> Les citations débutent par le signe > suivi d'une espace. Il n'est pas
nécessaire d'ajouter le signe > à chaque ligne.

> En revanche, il faut le remettre à chaque paragraphe.

    > Les citations débutent par le signe > suivi d'une espace. Il n'est pas
    nécessaire d'ajouter le signe > à chaque ligne.
    
    > En revanche, il faut le remettre à chaque paragraphe.

## Conventions typographiques

### Dialogues

Les dialogues sont précédés d'un tiret cadratin — ( et **pas** d'un trait
d'union). Le tiret dacratin est plus large que le trait d'union.

    — tiret cadratin
    - trait d'union

### Guillemets

Les guillemets français « » doivent être préférés à leur équivalent
anglais "", sauf utilisation explicite dans l'édition numérisée.

[1]: http://www.laquadrature.net/fr
[2]: https://fr.wikipedia.org/wiki/Paul_d%27Ivoi
[3]: https://fr.wikipedia.org/wiki/Paul_d%27Ivoi#Les_Voyages_excentriques
