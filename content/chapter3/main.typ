// ~ src/content/chapter_3/__main__.tex
#import "../../lib/math.typ": *

= Détermination du diamètre optimal des intervalles à considérer pour l'estimation de la régularité locale <chap:determination-delta>

Nous avons désormais établi que la génération d'un $op("FAR")(1)$ basé sur un mouvement brownien multi-fractionnaire permettait de contrôler de bout-en-bout la régularité du processus. Ceci va nous permettre de pouvoir analyser correctement le comportement du risque d'estimation de la régularité en fonction de $Delta$, ainsi que le comportement du $Delta^*$ optimal.

== Choix des paramètres de la simulation des $op("FAR")(1)$ localement Hölderiennes <sec:choix-des-parametres-de-la-simulation>
#include "simulation-params.typ"

== Prélissage des données simulées <sec:prelissage-des-donnees-simulees>
#include "pre_lissage.typ"

== Choix du couple d'incréments à estimer <sec:choix-couple-increment>
#include "choix_couple_increment.typ"

== Discussion <sec:methodo_discussion>
#include "discussion.typ"
