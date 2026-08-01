// ~ src/content/chapter_3/discussion.tex
#import "../../lib/math.typ": *
#import "../../lib/components.typ": warn, blackboxed

Il est important de garder en tête le modèle dans lequel on s'est placé pour étudier le comportement du $Delta$. La recommendation qui est faite pour la sélection du $Delta$ est valable pour :

#warn[
  - $op("FAR")(1)$ construit à partir d'un $op("mfBm")(H, L)$
  - la régularité donnée par $H(t)$ et dans notre cas : $H in cal(C)^infinity ([0,1])$
  - le noyau de la relation auto-régressive $beta$ est une fonction de classe $cal(C)^infinity$ sur $]0, 1]$ et continue en $0$
  - La dérivée de $H$ est $H' : t |-> frac(2 e^(-5(t-0.5)), (1 + e^(-5(t-0.5)))^2)$, la dérivée maximale de la régularité est atteinte en $argmax_(t in [0,1]) H'(t) = 1/2$ avec $H'(1/2) = 1/2$
  - La régularité est monotone et strictement croissante sur $[0,1]$
  - la constante «#h(0.1em)locale#h(0.1em)» de Hölder $L : t |-> L_t$ est en réalité constante sur l'ensemble du support dans le cadre de nos simulations
]

Trop s'éloigner de ces hypothèses pourrait demander d'analyser de nouveau le comportement du $Delta$ dû aux propriétés de certaines de ces quantités qui auraient pu influencer le résultat. C'est pourquoi on recommande avec des affirmations du type «#h(0.1em)vers le point le plus régulier#h(0.1em)» plutôt qu'avec la position. Un exemple de l'importance de ces hypothèses et du cadre de simulation est que le $Delta$ optimal obtenu pour le risque euclidien relatif était dans la grande majorité des cas $Delta^* = 0.2$. Ce qui peut sembler surprenant pour l'estimation d'une régularité _locale_. Toutefois, la fonction de Hurst est très régulière et varie même lentement sur la majorité du support. Ainsi il est plus raisonnable de penser que l'on peut aller chercher de l'information plus loin, sans trop perdre l'information locale.

De plus, il est à noter que le choix du risque apporte une conclusion différente sur la détermination de $Delta$ à choisir en pratique. Le choix du risque euclidien relatif à la norme de la cible semble être un choix qui fait plus sens à la fois d'un point de vue méthodologique (étant donné que la norme de la cible varie avec $Delta$) mais aussi par chance qui se trouve être un choix qui mène à une règle de détermination assez simple du $Delta$ avec une courbe de risque qui semble mieux se comporter.

On pourra enfin noter les différents pics présents à certaines valeurs de $Delta$ dans les graphes de risque. Après investigation des courbes des réplications de monte-carlo présentant des cas extrêmes ( comme par exemple un risque euclidien non relatif s'élevant jusqu'à 80 — comme sur la figure #ref(<fig:dist_R_eucl_curves>) ), Il semblerait que cela soit dû à l'estimation de $X(t_1), X(t_3)$ non loin, ou bien même dans un «#h(0.1em)trou d'observation#h(0.1em)». Le praticien doit donc faire attention lors de l'estimation de la régularité si il obtient des résultats peu concluants, si les courbes initiales possèdent peu de points (ou pas de points) proches des temps $t_1(Delta), t_2(Delta)$ ou $t_3(Delta)$. Auquel cas, pour estimer la régularité deux pistes se présentent :

- estimer la régularité par les statistiques d'ordre, pour le voisinage des points problématiques via la méthode de Golovkine et al. (2022) Il s'agit donc de la méthode recommandée pour les cas pathologiques.

- *( ⚠ conjecture )* Investiguer sur le potentiel de lisser via une base de fonction, qui ne détruit pas trop les informations de régularité, comme la base d'ondelettes. Ce qui rend la base d'ondelettes particulièrement intéressante est d'ailleurs explicité en annexe #ref(<annexe:wavelet>).

#v(3em, weak: true)

#blackboxed[✎ ajout de la version corrigée sur le $Delta arrow.r 0.2$]

Conformément aux observations faites par MPV et Golovkine et al. #cite(<maissoro-SmoothnessFTSweakDep>) #cite(<golovkineRegularityOnlineEstimationNoisyCurve>), on peut comprendre la préférence du choix d'un diamètre de voisinage $Delta$ pour estimer la régularité _locale_ aux alentours de 20% du support par le fait que l'estimateur cherche au maximum de s'éloigner de la corrélation dans les données vis à vis de l'argument $t in cal(T)$ des fonctions $X_i$. Cela ne change en rien la conclusion mais vient certainement apporter un peu de clarté dans la conclusion très contre-intuitive de régularité locale estimée avec de l'information répartie sur 20% du support des données.
