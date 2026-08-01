// ~ src/content/chapter_3/simulation-params.tex, chapter_3/simulation-parametres/*
#import "../../lib/math.typ": *
#import "../../lib/components.typ": info
#import "../../lib/plot.typ": plot-2d, wireframe3d
#import "../../lib/theme.typ": flat

#info[
  Il est conseillé de se référer aux tableaux #link(<table-notations>)[[ Notations Spécifiques au stage ]]
  et #ref(<tab:model>) pour la signification des notations déjà introduites et utilisées dans ce chapitre.
]

=== Nombre de simulations <subsec:nb-simulations>

Afin d'étudier la relation entre le $Delta$ optimum et différentes quantités caractéristiques aux données, on va effectuer une simulation de Monte-Carlo.

On décide de générer $sans("mc") = 200$ simulations de Monte-Carlo, afin d'obtenir les résultats les plus robustes possibles pour l'estimation du risque $esperance(distnorme(2, hat(Theta), tilde(Theta)))$#footnote[le raisonnement pour le choix du risque utilisé sera explicité en section #ref(<sec:choix_risque_couple>)], tout en gardant un temps de calcul raisonnable. On fait varier $lambda$ de $30$ à $480$ en incrémentant de $15$ à chaque fois. L'idée et de pouvoir regarder si il existe une relation entre $Delta^*$ et la position du nombre moyen de points observés par courbe $(lambda)$ par rapport au nombre de courbes $(N)$.

Il est possible de voir comment les paramètres que l'on va définir sont utilisés dans l'implémentation en annexe #ref(<annexe:code>).

=== Fonction de Hurst <sec:sim_fcn_hurst>

#grid(
  columns: (0.47fr, 0.47fr),
  column-gutter: 1fr,
  [
    On appelle $H : t |-> H_t$ la fonction de Hurst. Celle qui a été choisie est la suivante :

    $ H^([h_l, h_r, s, "pos"])_sans("logistic") : func([0,1], [h_l, h_r], t, h_l + frac(h_r - h_l, 1 + e^(-s(t - "pos")))) $

    La fonction de Hurst retenue est la suivante :

    $ H^([0.4, 0.8, 5, 0.5])_sans("logistic") $

    On dispose donc d'une régularité locale qui varie sur $cal(T)$, tout en ayant une évolution pas trop brusque. Nous allons étudier le comportement du $Delta$ lors de l'estimation de la régularité locale en les points suivants :

    $ arrow(t) = vec(0.3, 0.4, 0.5, 0.6, 0.7, 0.8)
      quad quad
      H(med arrow(t) med) = vec(0.51, 0.55, 0.6, 0.65, 0.69, 0.73) $
  ],
  [
    #let hurst-logistic(t) = 0.4 + (0.8 - 0.4) / (1 + calc.exp(-5 * (t - 0.5)))
    #figure(
      plot-2d(
        size: (7.5, 6), x-range: (0, 1), y-range: (0.4, 0.8),
        x-ticks: ((0, [0]), (0.5, [0.5]), (1, [1])),
        y-ticks: ((0.4, [0.4]), (0.6, [0.6]), (0.8, [0.8])),
        curves: ((fn: hurst-logistic, domain: (0, 1), samples: 200, color: flat.blue, stroke: 1pt),),
        markers: ((0.3, 0.51), (0.4, 0.55), (0.5, 0.6), (0.6, 0.65), (0.7, 0.69), (0.8, 0.73)).map(p => (x: p.at(0), y: p.at(1), color: black)),
        legend: ((color: flat.blue, label: [Fonction de Hurst]), (color: black, label: [Points d'estimation de la régularité locale])),
      ),
      caption: [Hurst Function: Logistic],
      kind: image, supplement: [Figure],
    ) <plot:hurst-logistic>
  ],
)

=== Constante de Hölder <subsec:constante-holder>

On décide de simuler des mouvements browniens multi-fractionnaires de constante de Hölder $L_t$ identique sur tout le support.

$ forall t quad L_t = 1 $

=== Moyenne <subsec:moyenne>

#grid(
  columns: (0.47fr, 0.47fr),
  column-gutter: 1fr,
  [
    La fonction moyenne du processus utilisée pour la simulation est la suivante :

    $ mu : func([0,1], bb(R), t, 4 dot sin(3/2 pi dot t)) $
  ],
  [
    #figure(
      plot-2d(
        size: (7.5, 6), x-range: (0, 1), y-range: (-4, 4),
        x-ticks: ((0, [0]), (0.5, [0.5]), (1, [1])),
        y-ticks: ((-4, [-4]), (0, [0]), (4, [4])),
        curves: ((fn: t => 4 * calc.sin(3.0 / 2.0 * calc.pi * t), domain: (0, 1), samples: 200, color: flat.blue, stroke: 1pt),),
      ),
      caption: none, outlined: false,
      kind: image, supplement: [Figure],
    ) <plot:mu>
  ],
)

=== Noyau de la relation FAR(1) <subsec:noyau-far>

#grid(
  columns: (0.48fr, 0.48fr),
  column-gutter: 1fr,
  [
    On décide de simuler un FAR(1) basé sur un opérateur linéaire intégral :

    $ X_(n+1) = phi.alt(X_n) + epsilon.alt_(n+1) $

    avec : $phi.alt : f |-> display(integral_cal(T) f(u) beta(u, dot.op) thin d u)$

    C'est une modélisation fréquente des FAR(1). Le noyaux que l'on considère dans l'opérateur intégral pour les simulations est le suivant :

    $ beta : med func([0,1]^2, bb(R), (t,s), 9/4 t sqrt(s(1-s))) $
  ],
  [
    #figure(
      wireframe3d(
        (t, s) => 9.0 / 4.0 * t * calc.sqrt(s * (1 - s)),
        x-range: (0, 1), y-range: (0, 1), z-range: (0, 1), divisions: 16, size: 6,
      ),
      caption: [Graphique du noyau intégral pour la relation FAR(1)],
      kind: image, supplement: [Figure],
    ) <graph:far_kernel>
  ],
)

On notera que le noyaux utilisé pour la relation de $op("FAR")(1)$ est une fonction lisse. Ainsi il remplit aisément la condition pour que le $op("FAR")(1)$ hérite de la régularité du mouvement brownien multi-fractionnaire généré.

=== Nombre de courbes <subsec:nb-courbes>

Afin d'étudier le lien potentiel qu'il pourrait y avoir entre le nombre de courbes observées et le $Delta$ optimal pour l'estimation de la régularité locale, on choisit plusieurs valeurs de nombres de courbes observées de telle sorte à avoir un «#h(0.1em)petit#h(0.1em)» et un «#h(0.1em)grand#h(0.1em)» nombre de courbes observées.

On choisit les valeurs suivantes concernant le nombre de courbes observées :

$ arrow(N) = [100, 200, 300, 400] $

Ainsi on traîte les cas de ce qu'on pourrait considérer comme la limite avant d'entrer dans un cas «#h(0.1em)sparse#h(0.1em)» (en terme du nombre d'observations de courbe), jusqu'à un nombre de courbe que l'on peut considérer important.

=== Nombre moyen de points observés par courbe <subsec:nb-moy-pts-obs-par-courbe>

Le nombre de points observés sur la courbe $X_n$ est défini comme étant la variable aléatoire $M_n$. Dans le cadre de notre simulation, $M_n$ suit une loi de poisson de paramètre $lambda$. Ainsi, $esperance(M_n) = lambda$ dans le cadre de notre simulation.

On effectue donc une simulation d'un échantillon de série temporelle $op("FAR")(1)$ par nombre moyen de points que l'on souhaite observer sur les courbes ($lambda$). Afin de traîter différents cas, d'observation «#h(0.1em)dense#h(0.1em)» à observation «#h(0.1em)sparse#h(0.1em)» (dans le sens du nombre de points par courbe), on fait varier $lambda$ de $30$ points par courbe en moyenne à $480$ points. L'idée est de voir ensuite si il y a une relation entre le $Delta^*$ et le fait que l'on ait $lambda$ petit, similaire ou grand par rapport à $N$.

=== Ensemble des Δ testés <subsec:delta-test>

On souhaite obtenir plusieurs graphiques avec $Delta$ sur l'axe des abscisses afin de pouvoir étudier le comportement de diverses quantitées, dont le risque euclidien, lorsque l'on fait varier $Delta$ avec certains paramètres fixés (nombre de courbes observées, nombre moyen de points observés par courbe, ...). Toutefois plus on va considérer de $Delta$, et plus la simulation sera coûteuse. En effet, on a vu en section #ref(<rem:inversion_matrice_covariance_mfbm_informel>) que l'odre de complexité de la simulation du mfBm est de $cal(O)(op("card") bb(T)^3)$, avec $bb(T)$ les points où l'on doit évaluer nos $famfinie(X, 1, n)$. Dans notre cas, le nombre de points considérés pour la simulation est :

$ underbracket(dim arrow(Delta), 30) times underbracket(3, t_1\/t_2\/t_3) times underbracket(dim arrow(t), 6) + underbracket(n_(sans("Grid_") integral), 100) + underbracket(lambda, lt.eq 480) lt.eq underbracket(640, sans("fixe")) + underbracket(480, sans("pts aleat")) = 1 med 120 $

Pour assurer un équilibre entre le nombre de points et les temps de simulation, nous choisissons 30 valeurs uniformément réparties entre 0.01 et 0.2 pour $Delta$. Au-delà de cette plage, la largeur des intervalles pour l'évaluation de la régularité devient disproportionnée par rapport à la taille du support, rendant inappropriée la notion de «#h(0.1em)régularité locale#h(0.1em)».

$ arrow(Delta) = [0.01 dots.c 0.2]_30 $

=== Bruit blanc <subsec:bruit-blanc>

Une fois que l'on a simulé :

$ famfinie(X, 1, n) quad sans("vérifiant") quad X_(n+1) = phi.alt(X_n) + xi_n $

on doit désormais reproduire l'erreur de mesure, pour cela chaque courbe est ensuite bruitée en rajoutant un bruit blanc :

$ eta tilde cal(N)(0, 0.04) $

Il est important d'avoir un bruit blanc d'écart type d'un ordre de grandeur en dessous de celui des valeurs prises par le processus, sinon l'estimation serait mauvaise quoi qu'il arrive. En effet le bruit écraserait à lui tout seul toute l'information fine de régularité.

=== Résumé des Paramètres <subsec:resume-params-simul>

#let gray-cell(body: none) = table.cell(fill: rgb("#c0c0c0"), if body == none { [] } else { body })

#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    align: (left + horizon, center + horizon, center + horizon, center + horizon, center + horizon),
    stroke: 0.5pt,
    inset: (x: 8pt, y: 6pt),
    table.header([], [*nombre de valeurs testées*], [*de*], [*jusqu'à*], [*valeur*]),
    emph(strong[$Delta$]), $30$, $0.01$, $0.2$, gray-cell(),
    emph(strong[$lambda$]), $30$, $30$, $480$, gray-cell(),
    emph(strong[$N$]), $4$, $100$, $400$, gray-cell(),
    emph(strong[Erreur de mesure : ($sigma_eta$)]), gray-cell(), gray-cell(), gray-cell(), $0.2$,
    emph(strong[nb simulations MC]), gray-cell(), gray-cell(), gray-cell(), $200$,
  ),
  caption: [Hyper-paramètres de la simulation Monte-Carlo],
  kind: table, supplement: [Table],
) <tab:hyperparam-mc>
