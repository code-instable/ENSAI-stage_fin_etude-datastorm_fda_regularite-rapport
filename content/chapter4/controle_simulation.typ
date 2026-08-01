// ~ src/content/chapter_4/__main__.tex (§ Contrôle de la procédure sur des données simulées)
#import "../../lib/math.typ": *
#import "../../lib/components.typ": chk, blueboxed
#import "../../lib/theme.typ": numeq

Il est important que les données de test n'aient pas été utilisées pour déterminer la procédure. Pour vérifier que la procédure fonctionne comme prévu, on génère de nouvelles données aux caractéristiques suivantes :

#figure(
  table(
    columns: (1.3fr, auto, auto, 1.2fr),
    align: (left + horizon, center + horizon, center + horizon, left + horizon),
    stroke: 0.5pt,
    inset: (x: 6pt, y: 5pt),
    table.hline(stroke: 1pt),
    table.header([*Nombre moyen d'observations par courbe*], [*symbole*], [*variation*], [*valeur*]),
    table.hline(stroke: 1pt),
    table.cell(rowspan: 3)[Nombre moyen d'observations], table.cell(rowspan: 3)[$lambda$], [sparse], [80],
    [moyen], [180],
    [dense], [300],
    table.hline(stroke: 0.6pt),
    table.cell(rowspan: 3)[Nombre de courbes], table.cell(rowspan: 3)[$N$], [sparse], [100],
    [moyen], [200],
    [dense], [300],
    table.hline(stroke: 0.6pt),
    [Nombre de simulations de monte carlo], $m c$, [], [200],
    table.hline(stroke: 0.6pt),
    [Points d'estimation de la régularité], $arrow(t)$, [], $[0.3, 0.6, 0.8]$,
    table.hline(stroke: 0.6pt),
    table.cell(rowspan: 2)[Fonction de Hurst], $H_1$, [même que sim], $t |-> H^([0.4, 0.8, 5, 0.5])_sans("logistic") (t)$,
    $H_2$, [pente plus abrupte], $t |-> H^([0.4, 1, 16, 0.6])_sans("logistic") (t)$,
    table.cell(rowspan: 2)[Valeurs de régularité testées], $H_1 (med arrow(t) med)$, [même que sim], $[med 0.51, 0.65, 0.73 med]$,
    $H_2 (med arrow(t) med)$, [pente plus abrupte], $[med 0.40, 0.70, 0.98 med]$,
    table.hline(stroke: 0.6pt),
    [constante de régularité locale], $L_t$, [constante], [3],
    table.hline(stroke: 1pt),
  ),
  caption: [Paramètres de simulation des données de test],
  kind: table, supplement: [Table],
) <tab:sim_test_params>

Puis on estimera la régularité de chacune de ces courbes, et on comparera les résultats obtenus avec les valeurs théoriques.

=== Détermination du $Delta$ en utilisant la procédure

Nous choisissons, en accord avec la section précédente, le $Delta$ suivant :

$ Delta^sans("proc") = 15% sans(" du support") thin . $

=== Conclusion sur la qualité de la détermination du $Delta$ via l'utilisation de la procédure

De la même manière que dans l'annexe #ref(<annexe:choix-du-rique>), on retire sur les 200 échantillons de monte carlo simulés, les échantillons «#h(0.1em)extrêmes#h(0.1em)» où une observation peut potentiellement faire exploser le risque (auquel cas on rappelle que l'on conseille la méthode de Golovkine et al. (2022) par la statistique d'ordre si les résultats sont insatisfaisants sur le voisinage problématique). On note $sans("mc")_(R e t)$ le nombre de simulations de Monte-Carlo retenues dans le calcul après filtrage des «#h(0.1em)extrêmes#h(0.1em)».

Les risques affichés par la suite sont pour $N=200$, $lambda = 180$.#footnote[Les tableaux de risque pour les autres valeurs mentionnées précédemment sont disponibles en annexe] On considère l'estimation du couple

#grid(
  columns: (0.45fr, 0.45fr),
  column-gutter: 1fr,
  align(horizon)[
    $ tilde(thetaB) = vec(tilde(theta)(t_1, t_3), tilde(theta)(t_2, t_3)) $
  ],
  align(horizon)[
    Que l'on estime avec $hat(thetaB) = vec(hat(theta)(t_1, t_3), hat(theta)(t_2, t_3))$
  ],
)

==== Qualité d'estimation du couple d'incréments $tilde(thetaB)$ : risque relatif

#figure(
  table(
    columns: (auto, auto, 1fr, auto, 1fr, 1fr),
    align: (left + horizon, left + horizon, center + horizon, center + horizon, center + horizon, center + horizon),
    stroke: 0.5pt,
    inset: (x: 5pt, y: 5pt),
    table.hline(stroke: 1pt),
    table.header(
      $t$, $H_t$, $hat(cal(R))^(["rel"]) (Theta, Delta)$, $sans("mc")_(R e t)$,
      strong[$op("med") hat(cal(R))^(["rel"])_(m c) (Theta, Delta)$], strong[$bb(V)[hat(cal(R))^(["rel"])_(m c) (Theta, Delta)]$],
    ),
    table.hline(stroke: 0.6pt),
    table.cell(rowspan: 2)[Moins Régulier], $H_1 : 0.51$, $2.9 dot 10^(-3)$, $dots.v$, $2.3 dot 10^(-3)$, $5.0 dot 10^(-6)$,
    $H_2 : 0.40$, $7.8 dot 10^(-3)$, $dots.v$, $5.1 dot 10^(-3)$, $1.1 dot 10^(-4)$,
    table.hline(stroke: 0.6pt),
    table.cell(rowspan: 2)[Inflexion], $H_1 : 0.65$, $9.0 dot 10^(-5)$, $dots.v$, $4.9 dot 10^(-5)$, $1.2 dot 10^(-8)$,
    $H_2 : 0.70$, $1.5 dot 10^(-3)$, [198 (/200)], $5.0 dot 10^(-5)$, $2.3 dot 10^(-4)$,
    table.hline(stroke: 0.6pt),
    table.cell(rowspan: 2)[Plus régulier], $H_1 : 0.73$, $1.1 dot 10^(-4)$, $dots.v$, $6.7 dot 10^(-5)$, $1.5 dot 10^(-8)$,
    $H_2 : 0.98$, $2.3 dot 10^(-3)$, $dots.v$, $7.8 dot 10^(-5)$, $3.1 dot 10^(-4)$,
    table.hline(stroke: 1pt),
  ),
  caption: [Table du risque relatif sur l'estimation du couple $tilde(thetaB)$ pour $lambda=180, N=200$],
  kind: table, supplement: [Table],
) <tab:qualite_estim_increments_relatif_new_sim>

#chk[
  On peut constater que les risques relatifs observés sur l'estimation du couple $tilde(thetaB)$ pour de tous nouveaux paramètres de simulation sur lesquels la procédure de sélection du $Delta$ n'a pas été déterminée ($H_2$) sont aussi très bons ce qui donne confiance en la procédure.
]

=== Qualité d'estimation de la régularité

#figure(
  {
    align(center)[$N = 200$, $lambda = 180$ | $hat(cal(R))(t) = display(1/(m c) sum_(i=1)^(m c) (hat(H_t)[i] - H_t)^2)$]
    v(0.7em)
    grid(
      columns: (1fr, 1fr, 1fr),
      column-gutter: 0.5em,
      align(center)[
        #image("/src/Images/regularite_qualite_estimation/N200_lbd180_box3_2.jpg", width: 100%)
        moins régulier : H = 0.40
      ],
      align(center)[
        #image("/src/Images/regularite_qualite_estimation/N200_lbd180_box6_2.jpg", width: 100%)
        inflexion : H = 0.70
      ],
      align(center)[
        #image("/src/Images/regularite_qualite_estimation/N200_lbd180_box8_2.jpg", width: 100%)
        plus régulier : H = 0.98
      ],
    )
  },
  caption: [Distribution des risques sur l'estimation du paramètre de régularité locale : $H_t$],
  kind: image, supplement: [Figure],
) <fig:H_error_boxplot>

=== Qualité d'estimation de la fonction moyenne : Critère Local

Nous nous intéressons désormais à la qualité d'estimation de la fonction moyenne en respectant la procédure décrite précédemment pour la sélection du $Delta$.

#figure(
  table(
    columns: (auto, auto, 1fr, 1fr, 1fr, auto, auto),
    align: (left + horizon, left + horizon, center + horizon, center + horizon, center + horizon, center + horizon, center + horizon),
    stroke: 0.5pt,
    inset: (x: 5pt, y: 5pt),
    table.hline(stroke: 1pt),
    table.header(
      $t$, $H_t$, $hat(cal(R))(t) sans(" avec ") cal(R) = sans("MSE")$,
      strong[$op("med") (hat(cal(R))_(m c) (t))$], strong[$bb(V)[hat(cal(R))_(m c) (t)]$], $N$, $lambda$,
    ),
    table.hline(stroke: 0.6pt),
    table.cell(rowspan: 2)[Moins régulier], $H_1 : 0.51$, $5.4 dot 10^(-3)$, $2.6 dot 10^(-3)$, $5.5 dot 10^(-5)$, table.cell(rowspan: 6)[200], table.cell(rowspan: 6)[180],
    $H_2 : 0.40$, $1.4 dot 10^(-2)$, $5.0 dot 10^(-3)$, $4.4 dot 10^(-4)$,
    table.hline(stroke: 0.6pt, start: 0, end: 5),
    table.cell(rowspan: 2)[Inflexion], $H_1 : 0.65$, $8.0 dot 10^(-3)$, $4.4 dot 10^(-3)$, $8.2 dot 10^(-5)$,
    $H_2 : 0.70$, $3.5 dot 10^(-2)$, $1.8 dot 10^(-2)$, $2.7 dot 10^(-3)$,
    table.hline(stroke: 0.6pt, start: 0, end: 5),
    table.cell(rowspan: 2)[Plus régulier], $H_1 : 0.73$, $5.2 dot 10^(-3)$, $2.5 dot 10^(-3)$, $4.3 dot 10^(-5)$,
    $H_2 : 0.98$, $4.0 dot 10^(-2)$, $1.8 dot 10^(-2)$, $2.8 dot 10^(-3)$,
    table.hline(stroke: 1pt),
  ),
  caption: [Risques quadratiques (MSE) de l'estimation adaptative de la fonction moyenne],
  kind: table, supplement: [Table],
)

=== Conclusion sur la validité de la procédure de sélection du 𝛥

#chk[
  #align(center)[
    L'analyse des risques sur l'estimation du paramètre de régularité $H_t$ ainsi que sur l'estimation de la fonction moyenne $mu$ sur des données simulées avec de nouveaux paramètres semble indiquer que la procédure de sélection du $Delta$ fonctionne comme prévu.
  ]
]

#align(center, box(width: 100%, stroke: 0.5pt + black, inset: 1em)[
  #blueboxed[✎ commentaire (personnel)] Il aurait été judicieux de considérer une fonction de Hurst décroissante (en inversant $h_ell$ et $h_r$ dans la définition de $H_t$), pour vérifier l'indépendance de la méthode vis-à-vis du sens de monotonicité de celle-ci. Une autre expérience possible serait considérer une fonction non monotone et de regarder en un point de croissance et en un point de décroissance (de pente opposée).
])
