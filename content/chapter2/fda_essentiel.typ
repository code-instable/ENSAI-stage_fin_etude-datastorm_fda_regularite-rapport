// ~ src/content/chapter_2/01-fda_essentiel/*
#import "../../lib/math.typ": *
#import "../../lib/components.typ": info, warn, chk, question, citer, colorize, fbox
#import "../../lib/theorems.typ": definition-star, thm-star, propriete-star, rem

=== Définitions et propritétés informelles <sec:informel>

Nous allons dans cette section introduire la notion de donnée fonctionnelle ainsi que les propriétés les plus utiles lorsqu'on les manipule. On y regroupe l'ensemble des messages essentiels à retenir des données fonctionnelles pour la pratique, sans alourdir les notions avec des notations mathématiques. Le cadre formel est traîté en annexe #ref(<annexe:fda-formel>).

#definition-star(name: [données fonctionnelles — informel], key: "def-star:fda")[
  Les données fonctionnelles sont des données dont les observations sont des fonctions, c'est-à-dire des courbes, des surfaces, des images, thin dots.h

  i.e : toute donnée ayant une dépendance de type "relation fonctionnelle" avec un ou plusieurs paramètres.
]

#figure(
  {
    align(center, image("/src/Images/sketches/fda_surface.jpg", width: 80%))
    v(0.7em)
    align(center)[
      *Gauche :* exemple de surface \
      *Droite :* échantillon de deux observations de la surface suivant une loi fonctionnelle
    ]
  },
  caption: [Donnée fonctionnelle : relation fonctionnelle avec plusieurs paramètres],
  kind: image, supplement: [Figure],
) <fig:sketch_surface>

Maintenant introduites, les théorèmes suivant permettent de manipuler ces données à la fois pour la théorie et la pratique :

#thm-star(name: [Karhunen-Loeve — informel], key: "thm-star:KL")[
  #fbox[
    Il est possible pour une large classe de données fonctionnelles de les décomposer dans une base _de fonctions_ adaptée aux données (au sens de la covariance) que l'on appelle base ACP fonctionelle (*FPCA*).
  ]
]

#rem[
  La classe de fonctions pouvant être décomposées est large, puisqu'elle regroupe l'ensemble des processus qui nous intéressent la plus part du temps en tant que statisticien : celles qui sont à support sur un intervalle, admettant une covariance continue et finie sur le support.
]

On en déduit que pour travailler avec des données fonctionnelles, il suffit de les décomposer dans la base ACP fonctionnelle puis de travailler sur les composantes de chaque élément de la base. On travaille désormais avec des réels et non plus des fonctions, ce qu'on aime manipuler. On peut alors faire de la statistique traditionnelle avec les outils que l'on connait.

#propriete-star(name: [intérêt de la base FPCA — informel])[
  #fbox[
    la base ACP fonctionnelle est la plus économe, c'est à dire qu'elle explique au mieux la covariance des données pour un nombre de composantes fixées, ce qui est utile car on ne sait manipuler numériquement que des objets de dimension finie.
  ]
]

Pour avoir une bonne représentation de ces données, on doit donc s'assurer de bien estimer la covariance. Pour cela, on a mentionné qu'il serait judicieux de lisser les observations en tenant compte de la régularité du processus dont sont issues nos données. La question est désormais la suivante :

#question[
  Est-il possible de récupérer la régularité locale des trajectoires à partir des données ? Si oui, comment ?
]

C'est ce qu'affirme le théorème suivant provenant des travaux de Golovkine et MPV :

#thm-star(name: [Regularité locale — informel], key: "thm-star:regularite_locale")[
  #fbox[
    Les données fonctionnelles permettent de récupérer la régularité locale des trajectoires. Les estimateurs définis *ponctuellement* convergent.
  ]
]

#rem(name: [Continuité de Kolmogorov], key: "rem:kolmo_continuite")[
  Un théorème (Continuité de Kolmogorov) permet à partir de l'espérance d'incréments d'un processus aléatoire de déduire sa régularité.
  C'est pourquoi les estimateurs sont définis à partir des incréments quadratiques. C'est entre autres _la raison pour laquelle les données fonctionnelles permettent de récupérer la régularité locale des trajectoires_.
]

=== Résumé de l'intérêt de la modélisation fonctionnelle

Les données fonctionnelles permettent de travailler sur un modèle où la _relation_ entre plusieurs quantités est sujet à une loi#footnote[_cf_ données fonctionnelles — informel : #ref(<def-star:fda>)]. Ce point de vue de réplication de courbes est notamment utile car il permet d'extraire des observations leur régularité#footnote[_cf_ Continuité de Kolmogorov, Regularité locale — informel : #ref(<rem:kolmo_continuite>)]. L'estimation de cette régularité permet, entre autres, de lisser les courbes de façon appropriée en fonction de la quantité que l'on souhaite estimer, telle que la moyenne et la covariance avec une plus grande précision#footnote[_cf_ Estimateurs de la moyenne et de la covariance — informel #cite(<golovkine2021adaptive>) : #ref(<thm-star:estimation_adaptative>)].

#figure(
  image("/src/Images/sketches/sketch_resume_informel.jpeg", width: 90%),
  caption: [Résumé des motivations du de l'estimation de la régularité locale des trajectoires],
  kind: image, supplement: [Figure],
) <fig:sketch_resume_informel>

=== Cas non indépendant : séries temporelles de données fonctionnelles <sec:func_ts>

Il est commode en théorie des données fonctionnelles de supposer que l'on observe des courbes $X_i : Omega -> cal(C)^0 (I, bb(R))$ *indépendantes* et identiquement distribuées. Cependant une partie non négligeable des données que l'on observe ont des dépendances avec les valeurs passées.
Par exemple, il est raisonnable de penser que la consommation électrique d'un foyer au cours d'une année croît avec l'ajout successif de nouveau appareils électroniques.
L'hypothèse d'indépendance entre les données n'est donc plus pertinente pour les données que l'on traite et il devient important de considérer des processus autorégressifs adaptés aux données fonctionnelles.
Si dans le cadre des données de $bb(R)$ cette relation de _dépendance linéaire_ avec le passé pouvait s'écrire sous la forme suivante
$X_n = sum_(k=1)^(n-1) phi_k thin X_k + xi_n$ où $phi_k in bb(R)$
et
$xi_n cases(in va(bb(R)), indep sigma(X_i)_(1 : n-1))$,
dans le cadre fonctionnel on capture la même idée en considérant
$X_n = sum_(k=1)^(n-1) phi.alt_k (X_k) + xi_n$ où $phi.alt_k$
est un _opérateur linéaire_ de $bb(L)^2 (I, bb(R))$,
le plus souvent intégral.

#chk[
  Il s'agit d'une généralisation naturelle de la relation dans le cadre réel, puisqu'on peut démontrer que sur l'espace des nombres réels l'ensemble des fonctions linéaires $phi.alt : bb(R) -> bb(R)$ sont de la forme $x |-> a x$ avec $a in bb(R)$. La relation sur $bb(R)$ que l'on a vue juste avant peut alors se ré-écrire de façon similaire à la version fonctionnelle.
]

On considère lors de ce stage des données fonctionnelles sous forme de données indépendantes mais aussi sous forme de série temporelle : sur les données éoliennes chaque indice représente un parc éolien différent éloigné géographiquement (donc indépendants), là où les données photovoltaïques sont indexées non pas sur le parc photovoltaïque, mais sur la journée d'observation : présentant ainsi une dépendance temporelle claire.

#warn[
  On fera donc très attention à l'appellation historique _«#h(0.1em)série temporelle#h(0.1em)»_#footnote[Les séries temporelles sont régulièrement modélisées par des relations auto-régressives (AR) où l'observation $X_(n+1)$ est fonction de l'observation précédente : $X_(n+1) = F(X_n, epsilon.alt_(n+1))$ où $epsilon.alt_(n+1)$ correspond à de l'information nouvelle appelée «#h(0.1em)innovation#h(0.1em)». Beaucoup de personnes qui mentionnent «#h(0.1em)séries temporelles#h(0.1em)» parlent en réalité de relations auto-régressives, c'est de cela que l'on parle ici.], qui représente ici juste l'idée de dépendance d'un indice à l'autre. Il se peut que l'indice ait ou non une signification temporelle.
]

#question[
  Pourquoi se soucier en particulier des séries temporelles fonctionnelles lorsque l'on souhaite incorporer la régularité du processus dont est issu nos données dans l'estimation des quantités qui nous intéressent ?
]

Rappelons-nous que les données fonctionnelles sont la clé pour déterminer la régularité, et que cela est en réalité permis par le théorème de Continuité de Kolmogorov (que nous n'avons pas énoncé en détails, mais mentionné dans la section #ref(<sec:informel>)). Malheureusement, dans le monde réel où vit le praticien, nous n'avons pas accès à l'espérance de la loi dont sont issues nos données. Il nous faut donc estimer cette espérance, et c'est là que les séries temporelles fonctionnelles entrent en jeu. Puisque l'estimateur usuel de l'espérance est la moyenne empirique, qui nous est fourni par la loi des grands nombres#footnote[Dans le cadre où la variable aléatoire est dans un espace de fonction, la définition d'espérance et la convergence de la moyenne empirique (de fonctions) vers celle-ci, appelé loi des grands nombres, est plus délicate que sur $bb(R)$, le lecteur pourra se référer à #cite(<HsingEubankTheoreticalFoundationsOfFDA>)], cela devient très problématiques lorsque l'on dispose de données corrélées.
L'hypothèse de dépendance faible nous permet de tout de même utiliser l'estimateur usuel de l'espérance. Alors, les estimateurs des paramètres de régularité convergents ponctuellement vers ceux du processus dont sont issues nos données.

#figure(
  image("/src/Images/sketches/schema_ts_estim_reg.jpg", width: 100%),
  caption: [Schéma grossièrement récapitulatif : Estimation de la régularité pour une série temporelle fonctionnelle],
  kind: image, supplement: [Figure],
) <fig:recap_estim_reg_fts>

#warn[
  Il faut faire attention lorsque l'on manipule ou interprète des séries temporelles fonctionnelles. (comme par exemple tout résultat utilisant la loi de $sum_n X_n$, ... )
]

Une série temporelle discrète est le fait que l'observation suivante dépend linéairement de l'observation précédente, dans le cadre fonctionnel _l'observation est une fonction_. La dépendance se fait sur l'indice de la fonction, et non pas sur l'argument de la fonction interprété dans notre cas comme étant le temps.

Dans certains jeux de données c'est d'autant plus trompeur de parler de temps car on observe des courbes sur une année : à la fois l'indice de la fonction et l'argument de la fonction ont des interprétations temporelles.

#fbox[
  Dans l'expression «#h(0.1em)$X_n (t)$#h(0.1em)», la série temporelle (discrète) concerne bien l'indice $n$ et non pas l'argument $t$.
]

Étant donné que l'on souhaite estimer la régularité locale du processus il est naturel de se demander :

#question[
  Lorsque l'on a une dépendance dans les observations fonctionnelles ${X_1 dots X_n}$, possède-t-on une dépendance dans les observations ponctuelles à $t$ fixé ${X_1 (t) dots X_n (t)}$ ? Est-ce que l'on sait l'identifier ?
]

Et la réponse, c'est qu'*on ne sait pas*. En tout cas, dans le cadre général. Il y a en effet plusieurs façons de définir ce qu'on appelle par «#h(0.1em)dépendance#h(0.1em)». Toutes les définitions de dépendance ne mènent pas à cette conclusion, mais celle adoptée par (MPV) permet de passer de la dépendance fonctionnelle à une dépendance locale. De manière générale, lorsque l'on traîte des données avec de la dépendance, il convient d'être extrêmement précautionneux avec les théorèmes et «#h(0.1em)faits#h(0.1em)» que l'on invoque. #footnote[Le détail théorique de la validité de l'utilisation de la moyenne empirique comme estimateur de l'espérance sous hypothèse d'indépendance faible (proprement définie et motivée) est disponible en annexe #ref(<annexe:weak_dep>).]

#fbox[
  La dépendance faible comme définie dans l'article de MPV #cite(<maissoro-SmoothnessFTSweakDep>) nous permet de travailler localement : On peut travailler localement sur les trajectoires tout _en utilisant des hypothèses fonctionnelles_ (que ce soit pour la dépendance ou autres) pour obtenir la régularité.
]
