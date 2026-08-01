// ~ src/content/chapter_4/__main__.tex
#import "../../lib/math.typ": *
#import "../../lib/components.typ": colorize, emphcolor

= Application

== Généralités
#include "generalites.typ"

== Contrôle de la procédure sur des données simulées
#include "controle_simulation.typ"

== Application sur les données réelles de courbes de charge éolienne et photovoltaïque
#include "application_reelle.typ"

= Conclusion

Les données fonctionnelles constituent un paradigme intéressant pour l'analyse des courbes de charge. Si la théorie semble parfois être plus compliquée que celle dont on a l'habitude sur des données à valeurs dans $bb(R)^d$, elle suit néanmoins les mêmes grandes idées et principes que l'on a l'habitude de voir. Les données fonctionnelles devraient donc être accessibles aux statisticiens. Cette modélisation permet notamment de pouvoir extraire la régularité des trajectoires observées du processus que l'on étudie.

Une telle modélisation permet de prendre en compte de nombreuses caractéristiques des données. Parmi ces caractéristiques il y a notamment la régularité. La prise en compte de la régularité répond à plusieurs problématiques auxquelles le statisticien est souvent confronté :

- *Performance des prédictions :* savoir bien prédire des valeurs inobservées (potentiellement futures) est un enjeu majeur et critique de nombreuses applications. N'importe quel gain de performance peut s'avérer être un avantage concurrentiel non négligeable. Dans le cadre de la prise en compte de la régularité des trajectoires pour l'estimation de quantités pour des données fonctionnelles, l'amélioration de l'estimation peut s'avérer drastique en fonction de l'objet considéré. (#emphcolor[cf] #cite(<golovkine2021adaptive>) et #cite(<wei2023adaptive>) pour l'estimation de la covariance).
- *Interprétabilité & confrontation du modèle à la réalité :* modéliser un processus fondamentalement (du moins lorsque l'on a de bonnes raisons de le penser) non dérivable par des courbes $cal(C)^infinity$ ne semble pas être judicieux et impacte l'interprétabilité et la confiance en le modèle.
- *Analyse :* l'estimation de la régularité nous donne directement un nouvel outil pour essayer de comprendre les phénomènes que nous étudions en statistique. Ce n'est pas seulement un intermédiaire pour obtenir une bonne prédiction, mais aussi une source de nouvelles informations qui peuvent servir à analyser un phénomène et prendre des décisions. Si dans le cadre des courbes de charge photovoltaïques on pouvait se douter de la forme des paramètres de régularité, qu'en est-t-il des phénomènes dont on ne fait pas l'expérience sensorielle aussi fréquemment que la météo ? Dans certains phénomènes physiques, ou chimiques ayant des applications industrielles, l'analyse des courbes des paramètres de régularité sur le support peut permettre de mettre en évidence des phénomènes physiques ou chimiques qui n'auraient pas été mis en évidence par une analyse des courbes brutes.

Bien que la théorie des données fonctionnelles avec la prise en compte de la régularité des trajectoires soit encore aujourd'hui en pleine construction, il est d'ores et déjà possible de pouvoir estimer de nombreuses quantités prenant en compte cette régularité. Entre autres, nous pouvons mentionner les paramètres de régularité locale, la fonction moyenne, la covariance et même le noyau de la relation d'autorégression d'un modèle de séries temporelles fonctionnelles. Ces méthodes sont même implémentées dans le package R #raw("AdaptiveFTS", lang: "r") dérivé des travaux de MPV #cite(<maissoro-SmoothnessFTSweakDep>); et l'étude lors de ce stage de l'hyper-paramètre $Delta$ utilisé pour l'estimation de la régularité locale permettra désormais au praticien de pouvoir exploiter pleinement ces méthodes.
