// ~ src/content/chapter_2/02-regularite_locale/*
#import "../../lib/math.typ": *
#import "../../lib/components.typ": info, question, colorize, fbox, circled
#import "../../lib/theorems.typ": definition, rem
#import "../../lib/theme.typ": flat, numeq
#import "../../lib/plot.typ": weierstrass, plot-2d

=== Ce qu'on entend par régularité locale <sec:ce-qu-on-entend-par-reguarite-locale>

Longtemps, il était cru que les fonctions continues étaient dérivables presque partout. C'est notamment Weierstrass qui a démontré qu'il existe des fonctions continues partout mais dérivable nulle part. Poincaré notamment disait de tels objets qu'ils n'existaient que pour contredire le travail des pères.
Cependant, des objets manipulés tous les jours, comme le monde de la finance notamment, traitent des processus qui sont fondamentalement irréguliers#footnote[les fonctions dérivables nulle part sont même denses dans les fonctions continues pour la topologie de la convergence uniforme #cite(<gourdon2020maths-dense-non-deriv>). A epsilon près on rencontre toujours une fonction dérivable nulle part lorsque l'on considère la distance maximale réalisée entre deux fonctions continues sur leur support $I$...]
(du point de vue de l'analyse, où l'on traite souvent des fonctions au moins dérivables). Il est donc important de pouvoir quantifier la régularité d'une fonction de façon plus fine que le nombre de dérivées qu'elle possède.

Nous allons passer rapidement en revue les différents concepts de régularité pour mettre l'emphase sur ce que l'on considère comme régularité locale. Afin de savoir à quel niveau de régularité nous souhaitons estimer, il est important de garder en tête un ordre de différents niveaux de régularité résumé par les relations suivantes :

$ sans("Lipschitz") ==> sans("Hölder") ==> underbracket(colorize(sans("Localement Hölder")), sans("ce qui nous intéresse")) ==> sans("Uniformément continue") ==> sans("Continue") $

Si le lecteur souhaite discerner ce que chaque propriété signifie, et quelles sont les différences entre chaque niveau de régularité, il est possible de se rappeler rapidement les définitions de ces propriétés disponibles en annexe #ref(<annexe:regularite-def>).

#question[
  #align(center)[Pourquoi se concentrer sur des processus localement Hölder ?]
]

La nature des phénomènes rencontrés dans la vie réelle est souvent complexe. Influencés par de nombreux phénomènes, certains d'entre eux sont, comme mentionnés précédemment, irréguliers.
C'est notamment le cas des courbes de charge électrique, qui dépendent de multitudes de phénomènes physiques ou comportementaux, dont on peut attendre une certaine régularité, mais qui ne sont pas nécessairement uniformes tant sur leur niveau de régularité que l'intervalle de temps sur lequel ils ont une influence.
On pourrait par exemple attendre une différence de régularité de la production électrique en plein été (soleil et température stables …) comparé au mois de mars (plus grande instabilité des conditions climatiques).

De plus, les fonctions Hölderiennes représentent une classe suffisamment large de fonctions.
L'espace de fonctions sur lequel on travail devrait donc être en pratique suffisamment grand pour inclure l'ensemble des processus qui nous intéressent. Enfin les fonctions que le praticien sera amené à manipuler seront des fonctions d'un intervalle dans $bb(R)$, qui lorsque continues sont automatiquement uniformément continues en vertu du théorème de Heine. Il est donc naturel de se concentrer sur des fonctions localement Hölderiennes. #footnote[Afin de ne pas alourdir l'essence du propos, une simplification par rapport à l'article de MPV #cite(<maissoro-SmoothnessFTSweakDep>) a été faite, si le lecteur souhaite aller dans le détail, il est possible de se référer à l'Annexe #ref(<annexe:regularite-locale>).]

=== Modèle considéré

On dispose désormais de tous les ingrédients pour expliciter le modèle considéré pendant l'ensemble du stage :

#figure(
  table(
    columns: (1fr, auto, 1.3fr),
    align: (left + horizon, center + horizon, left + horizon),
    stroke: none,
    inset: (x: 6pt, y: 5pt),
    table.hline(stroke: 1pt),
    table.header([*Nom*], [*Objet*], [*Définition*]),
    table.hline(stroke: 0.6pt),
    [Régularité : constante locale], $L$, $func([0,1], bb(R), t, L_t)$,
    [Régularité : puissance locale de l'incrément], $H$, $func([0,1], [0,1], t, H_t)$,
    [donnée fonctionnelle], $X$, $in va(bb(L)^2 inter cal(H)(H, L))$,
    [$N$-échantillon de la loi de $X$], $(X_n)_(n in intervaleint(1, N))$, $X_n tilde X$,
    table.hline(stroke: 0.6pt),
    [Nombre de points sur la trajectoire de $X_n$], $M_n$, $tilde cal(P)(lambda)$,
    [Temps observés], $(T_n [m])_(m in 1:M_n)$, $tilde cal(U)([0,1])^(⊗ M_n)$,
    table.hline(stroke: 0.6pt),
    [écart type de l'erreur], $sigma$, $in Rplusetoile$,
    [erreur], $eta$, $tilde cal(N)(0, sigma^2)$,
    table.hline(stroke: 0.6pt),
    [noyau de l'opérateur intégral], $beta$, $in bb(L)^2 ([0,1])$,
    [relation auto-régressive intégrale], $phi.alt$, $func(bb(L)^2 ([0,1], bb(R)), bb(L)^2 ([0,1], bb(R)), f, integral_0^1 beta(u, dot.op) f(u) thin d u)$,
    [FAR(1)], $X_(n+1)$, $= phi.alt (X_n) + xi_(n+1)$,
    table.hline(stroke: 0.6pt),
    [observation], $Y_n [m]$, $= X_n (T_n [m]) + eta_n [m]$,
    [observation], $(T_n [m], Y_n [m])_(n,m)$, $in [0,1] times bb(R)$,
    table.hline(stroke: 1pt),
  ),
  caption: [Tableau récapitulatif du modèle considéré],
  kind: table, supplement: [Table],
) <tab:model>

=== Deux méthodes d'obtention de la régularité locale des trajectoires <sec:deux_methodes_estim>

Il existe deux méthodes différentes pour estimer la régularité des trajectoires. Si la clé des deux méthodes pour extraire la régularité locale est le théorème de continuité de Kolmogorov#footnote[_cf_ Annexe #ref(<annexe:continuite_kolmogorov>)], les deux méthodes diffèrent par les points $t in cal(T)$ considérés dans l'estimation des accroissements quadratiques $esperance(abs(X(u) - X(v))^2)$ utilisés pour l'estimation de la régularité locale.

La méthode de Golovkine et al. (2022) #cite(<golovkineRegularityOnlineEstimationNoisyCurve>, supplement: [pages : 7—9]) n'utilise que les points observés, et construit un estimateur des incréments quadratiques à base de statistique d'ordre.

$ theta(T_((l)), T_((k))) = esperance(abs(X(T_((l))) - X(T_((k))))^2) $
#grid(
  columns: (auto, 1fr),
  align: (right + horizon, left + horizon),
  column-gutter: 0.6em,
  row-gutter: 0.7em,
  $quad limits(approx)_sans("LGN")$,
  box(stroke: 0.5pt + black, outset: 4pt, $1/N sum_(n=1)^N abs(statrang(Y,n,2k-1) - statrang(Y,n,k))^2 isdef hat(theta)_k$),
  $quad limits(approx)^sans("Hölder")_(+ cal(C)^0 sans("Kol."))$,
  $L_(t_0) esperance(abs(ordered(T,l) - ordered(T,k))^(2H_(t_0)))$,
)

et on obtient ainsi l'estimateur suivant :

$ hat(H)_t (k) = cases(
  display(frac(log(hat(theta)_(4k-3) - hat(theta)_(2k-1)) - log(hat(theta)_(2k-1) - hat(theta)_k), 2 log 2)) & hat(theta)_(4k-3) > hat(theta)_(2k-1) > hat(theta)_k,
  1 & sans("sinon"),
) $

#info[Cette méthode peut s'avérer spécifiquement utile lorsque l'on traite un flux de données, car l'arrivée de nouvelles données ne nécessite pas spécifiquement de recalculer les incréments quadratiques sur l'ensemble des points observés. ]

L'autre méthode proposée dans les articles #cite(<golovkine2021adaptive>) #cite(<maissoro-SmoothnessFTSweakDep>), elle se base sur l'utilisation de points non observés, inférés par lissage des courbes, à une distance $Delta / 2$ les uns des autres pour estimer les incréments quadratiques.
Cette dernière méthode implique le choix d'un hyper-paramètre lors de l'estimation $Delta$ et pourrait être sensible à la qualité du lissage de la courbe.
Étant donné que l'objectif de la détermination de la régularité locale est de pouvoir faire un lissage à noyaux adaptatif en fonction de l'objet que l'on souhaite estimer, on appelle le lissage effectué pour estimer la régularité un «#h(0.1em)pré-lissage#h(0.1em)».

On se donne un $Delta in med ]med 0,1 med [ med$, arbitraire pour le moment, comme diamètre de l'intervalle $J_Delta$ que l'on considère pour évaluer la régularité en $t_0$.
Il est naturel de définir les points d'estimation de la régularité de la façon suivante :

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align(center)[
    $ t_1 & isdef t_0 - Delta/2 \
      t_2 & isdef t_0 \
      t_3 & isdef t_0 + Delta/2 $
  ],
  align(center)[
    $ J_Delta = [t_1, t_3] $

    avec $t_0$ le point en lequel on souhaite estimer la régularité.
  ],
)

#figure(
  grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    plot-2d(
      size: (7.5, 4.7), x-range: (0, 1.1), y-range: (-0.4, 0.4),
      curves: ((fn: x => weierstrass(2 * x, 2, 15), domain: (0, 1.1), samples: 800, color: flat.green, stroke: 0.7pt),),
      vlines: ((x: 0.275, color: flat.imperial), (x: 0.4, color: flat.imperial), (x: 0.525, color: flat.imperial)),
      markers: (
        (x: 0.4, y: weierstrass(0.8, 2, 15), color: flat.red-light),
        (x: 0.275, y: weierstrass(0.55, 2, 15), color: flat.imperial),
        (x: 0.525, y: weierstrass(1.05, 2, 15), color: flat.imperial),
      ),
      labels: (
        (at: (0.4, -0.08), body: [$t_2$], color: flat.imperial),
        (at: (0.275, -0.08), body: [$t_1$], color: flat.imperial),
        (at: (0.525, 0.1), body: [$t_3$], color: flat.imperial),
      ),
      brackets: ((from: 0.275, to: 0.525, y: -0.25, label: [$Delta$], color: flat.aqua),),
      legend: ((color: flat.green, label: [X]), (color: flat.red-light, label: [Point d'estimation de la régularité locale])),
    ),
    plot-2d(
      size: (7.5, 4.7), x-range: (0, 1.1), y-range: (-0.4, 0.4),
      curves: ((fn: x => weierstrass(2 * x, 2, 15), domain: (0, 1.1), samples: 800, color: flat.green, stroke: 0.7pt),),
      vlines: ((x: 0.025, color: flat.imperial), (x: 0.15, color: flat.imperial), (x: 0.275, color: flat.imperial)),
      markers: (
        (x: 0.025, y: weierstrass(0.05, 2, 15), color: flat.red-light),
        (x: 0.15, y: weierstrass(0.3, 2, 15), color: flat.imperial),
        (x: 0.275, y: weierstrass(0.55, 2, 15), color: flat.imperial),
      ),
      labels: (
        (at: (0.025, -0.08), body: [$t_1$], color: flat.imperial),
        (at: (0.15, -0.08), body: [$t_2$], color: flat.imperial),
        (at: (0.275, 0.1), body: [$t_3$], color: flat.imperial),
      ),
      brackets: ((from: 0.025, to: 0.275, y: -0.25, label: [$Delta$], color: flat.aqua),),
      legend: ((color: flat.green, label: [X]), (color: flat.red-light, label: [Point d'estimation de la régularité locale])),
    ),
  ),
  caption: [Exemple de courbe dont on souhaiterait déterminer la régularité locale, et visualisation de $J_Delta$ : estimation intérieure / au bord],
  kind: image, supplement: [Figure],
) <fig:delta_method_example>

#info[
  #rem[
    Rien n'empêche dans la théorie d'avoir les points $t_1, t_2, t_3$ non ordonnés dans le temps, mais dans la pratique, on considère naturellement que $t_1 < t_2 < t_3$. Mais cet ordre n'est pas obligatoire.
    Ainsi aux bords, si l'on souhaite estimer la régularité au point $t_0$ tel que la définition précédente nous donne un point $t_1$ en dehors de $[0,1]$, on peut tout à fait à la place considérer :

    #grid(
      columns: (1fr, 1fr),
      align(center)[
        $ t_2 isdef t_0 $
        $ t_1 isdef t_0 + Delta/2 $
        $ t_3 isdef t_0 + Delta $
      ],
      align(center)[
        Alors $J_Delta = [med t_2, t_3 med]$

        on pourra se référer à la 2#super[e] image de la figure #ref(<fig:delta_method_example>)
      ],
    )
  ]
]

#info[
  Le point $t_0$, où l'on souhaite estimer la régularité, étant dans la majorité des cas le point central de l'intervalle $J_Delta$ considéré; il sera à présent mentionné comme le point $t_2$. Il s'agit à la fois d'un moyen de se rappeler dans les formules suivantes que l'on considère le point central de l'intervalle $J_Delta$ et d'être au plus proche des noms de variables considérés dans l'implémentation.
]

Alors, on approche $theta(t_1, t_3) = esperance(abs(X(t_3) - X(t_1))^2)$ par :

#math.equation(numbering: numeq, block: true, $ tilde(theta)(t_1, t_3) = 1/N sum_(n=1)^N abs(X_n (t_3) - X_n (t_1))^2 $) <eq:theta_tilde>

qui n'est pas observable, étant donné qu'il n'est pas garanti d'observer $X(t_1)$ et $X(t_3)$, et qu'il faut donc lisser dans un premier temps les courbes pour pouvoir évaluer $X$ en $t_1$ et $t_3$. L'estimateur que l'on considère est donc une approximation de $tilde(theta)_13$, et est défini par :

#math.equation(numbering: numeq, block: true, $ hat(theta)(t_1, t_3) = 1/N sum_(n=1)^N abs(hat(X)_n (t_3) - hat(X)_n (t_1))^2 $) <eq:theta_hat>

où $hat(X)$ est la courbe lisssée à partir des observations :

$ (T_n [m], Y_n [m])_(n in 1:N , m in 1:M_n) $

avec :

- $N$ : Nombre de courbes observées
- $M_n$ : Nombre de points observés (aléatoire) sur la trajectoire de $X_n$

Les estimateurs des paramètres de régularité sont alors les suivants #cite(<maissoro-SmoothnessFTSweakDep>) :

#definition(name: [estimateurs des paramètres de régularité], key: "def:estim_reg")[
  #grid(
    columns: (1fr, 1fr),
    align(horizon)[
      #math.equation(numbering: numeq, block: true, $ hat(H)_(t_2) = frac(log hat(theta)(t_1, t_3) - log hat(theta)(t_1, t_2), 2 log 2) $) <eq:H_13_12>

      #align(center)[*ou*]

      #math.equation(numbering: numeq, block: true, $ hat(H)_(t_2) = frac(log hat(theta)(t_1, t_3) - log hat(theta)(t_2, t_3), 2 log 2) $) <eq:H_13_23>
    ],
    align(horizon)[
      $ hat(L)_(t_2) & = frac(hat(theta)(t_1, t_3), Delta^(2 hat(H)_(t_2))) \
        & limits(=)^"ou" frac(hat(theta)(t_1, t_2), Delta^(2 hat(H)_(t_2))) \
        & limits(=)^"ou" frac(hat(theta)(t_2, t_3), Delta^(2 hat(H)_(t_2))) $
    ],
  )
]

=== Prélissage <sec:regloc-prelissage>

Comme mentionné précédemment, l'estimation de la régularité locale nécessite l'évaluation de notre processus observé $X$ en 3 points. Il est possible de ne pas observer ces points, qui sont de plus bruités dû à l'erreur de mesure de $X$. C'est pourquoi nous décidons de lisser les courbes comme «#h(0.1em)pré-lissage#h(0.1em)» pour pouvoir estimer la régularité locale.

#question[
  #align(center)[Pourquoi parle-t-on de *pré*-lissage ? Le but de considérer la régularité n'était-il pas justement de l'utiliser dans le lissage des trajectoires ? Lisser avant même d'estimer la régularité n'est-il pas contre-productif ?]
]

L'objectif de l'obtention des paramètres de régularité des trajectoires est de pouvoir effectuer un lissage de ces trajectoires qui préserve les irrégularités fondamentales du processus dont elles sont issues, tout en éliminant le bruit. Les paramètres de régularité sont estimés avec des quantités temporellement équidistantes, qui sont donc potentiellement non observées. L'estimation de la régularité fait donc usage de trajectoires lissées. Les paramètres estimés sont ensuite utilisés pour effectuer un *nouveau lissage* à noyaux en utilisant, cette-fois, une fenêtre de lissage appropriée qui dépend de ces paramètres de régularité.

En d'autres termes, le pré-lissage utilise un lissage à noyaux tel que la fenêtre de lissage cross-validée nous donne :

#math.equation(numbering: numeq, block: true, $ h_sans("pre")^(*["cv"]) (t) sans(" estimateur de ") h^*_(cal(R)_sans("quadr")) (t) = grandop(lambda^(- 1/(2H_t+1))) $) <eq:h_cross_noyau_pre>

à partir duquel on peut lisser les courbes observées $(T_i^([n]), Y_i^([n]))_(n in 1:N, i in 1:M_n)$ pour estimer la régularité locale donnée par $H_t$ et $L_t$. On peut désormais obtenir la fenêtre de lissage adaptée à la quantité que l'on souhaite estimer :

$ h_mu^* (t) = argmin_(h in cal(H)) cal(R)_mu (underbrace(t, limits(->)^(H_t med , med L_t med , med cal(W)_t) sans("Régularité, sparsity, ...")), thin h thin) $

Le coeur de ce stage est la détermination du comportement de l'hyper-paramètre $Delta$, diamètre de l'intervalle que l'on considère dans lequel on vient prendre la valeur de notre processus en 3 points régulièrement espacés. MPV affirme déjà que pour un $Delta$ donné, on a bien la convergence ponctuelle des estimateurs. #cite(<maissoro-SmoothnessFTSweakDep>)
Toutefois, le praticien est en droit de se demander quel $Delta$ explicitement choisir ? Existe-t-il une procédure simple pour déterminer la valeur optimale de $Delta$ qu'il faut choisir pour obtenir un biais le plus petit possible pour l'estimation des paramètres de régularité ?

=== Résumé de la méthodologie d'estimation de la régularité locale

Résumons rapidement la méthode d'estimation de la régularité en un point $t_2 in cal(T)$.
La procédure d'obtention de la régularité est ainsi la suivante :

#circled[1] : Pré-lissage de la courbe

#circled[2] : Calcul des incréments quadratiques sur la courbe lissée

#circled[3] : Moyennage des incréments (estimateur de l'espérance)

#circled[4] : Utilisation de l'estimateur

Ce que nous cherchons désormais à déterminer est la réponse à la question suivante :

#question[
  #align(center)[Quel $Delta$ choisir pour obtenir la meilleure estimation de $H$ en $t_2$ ?]
]

Pour étudier cela, nous allons simuler des données FAR(1) Höldériennes de régularité connue et allons étudier quel $Delta$ fournit la meilleure estimation des paramètres de régularité en fonction de $lambda$, $N$, $H_t$, ... #footnote[on pourra se référer à #ref(<tab:model>) pour la signification des notations]

#figure(
  align(center, image("/src/Images/sketches/estim_reg.jpg", width: 90%)),
  caption: [Schéma résumé de la méthode d'estimation de la régularité],
  kind: image, supplement: [Figure],
) <fig:sketch_estim_reg_methodo>
