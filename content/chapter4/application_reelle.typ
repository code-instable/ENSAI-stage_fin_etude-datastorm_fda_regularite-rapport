// ~ src/content/chapter_4/__main__.tex (§ Application sur les données réelles...)
#import "../../lib/math.typ": *
#import "../../lib/theorems.typ": rem

=== Présentation des jeux de données

Les données que l'on traîte sont des courbes de charge provenant de différents moyens de production : éolien ou photovoltaïque. Comme mentionné en section #ref(<sec:func_ts>), il y a plusieurs façons de découper les données observées pour les modéliser par des données fonctionnelles : identifiant, temporel, ... Nous allons ici illustrer cet aspect en présentant deux jeux de données : un jeu de données éoliennes et un jeu de données photovoltaïques. Nous modélisons les données éoliennes de la façon suivante :

#let data-table(title, ..rows) = table(
  columns: (auto, 1fr),
  stroke: none,
  align: (left + horizon, left + horizon),
  inset: (x: 6pt, y: 7pt),
  table.hline(stroke: 1pt),
  table.cell(colspan: 2, strong(title)),
  table.hline(stroke: 0.6pt),
  ..rows.pos().flatten(),
  table.hline(stroke: 1pt),
)

#data-table(
  [Données éoliennes],
  ([support], [année identifiée comme $cal(T) = [0,1]$]),
  ([modèle fonctionnel], $forall i in I quad E_i : func(Omega times [0,1], bb(R)_+, (omega, t), e_i (t))$),
  ([indices], [éolienne individuelle : $I = {med sans("id du parc éolien") med}$]),
  ([observations], $hat(E) = {med (T_i [m], Y_i [m]) med : med i in intervaleint(1, N), m in intervaleint(1, M_i) } : Y_i [m] = E_i (med T_i [m] med) + eta_i [m]$),
  ([erreur de mesure], $(eta_i [m])_(I times intervaleint(1, M_i))$ + [ : indépendants 2 à 2]),
  ([dépendance], [données indépendantes car les éoliennes ne s'influencent pas sur leur production.]),
)

Nous allons maintenant présenter les résultats obtenus sur le jeu de données de production électrique photovoltaïque. Cette fois-ci, nous traîtons qu'un unique parc photovoltaïque et _une journée_ de production est représentée par _une courbe_. L'ensemble des courbes sont observées toutes les 30 minutes (suivant donc un schéma de «#h(0.1em)common design#h(0.1em)»). On dispose au total d'une année de données, soit 365 courbes. En résumé :

#data-table(
  [Données Photovoltaïques],
  ([support], [heure du jour identifiée comme $cal(T) = [0,1]$]),
  ([modèle fonctionnel], $V_i : func(Omega times [0,1], bb(R)_+, (omega, t), v_i (t))$),
  ([indices], [jour de l'année : $I = med intervaleint(1, 365)$]),
  ([observations], $hat(V) = {med (T_i [m], Z_i [m]) med : med i in intervaleint(1, N), m in intervaleint(1, M_i) } : Z_i [m] = V_i (med T_i [m] med) + eta_i [m]$),
  ([erreur de mesure], [$eta_i$ : indépendants 2 à 2]),
  ([dépendance], [série temporelle fonctionnelle : même parc, courbes journalières cycliques, indice temporel, observation dans le temps]),
)

#rem[
  On pourra constater que les données éoliennes et les données photovoltaïques rendent compte de la remarque faite en section #ref(<sec:func_ts>) : l'un des jeux de données est indexé sur le temps, l'autre sur un identifiant. De plus les données photovoltaïques présentent à la fois un indice et un support temporel.
]

=== Pré-traitement des données

La manipulation des séries temporelle requiert la stationnarité. Hors, la moyenne de production électrique des panneaux solaires varie dans l'année (durée des journées, fréquence de pluies, ...). Ainsi on découpe le jeu de données selon la saison, dans la suite du rapport nous nous concentrerons sur la courbe de charge pendant la période estivale (on pose donc $[med 21\/06\/2017, med 22\/09\/2017] = cal(T) isdef [0, 1]$). Enfin, on décide de ne pas estimer sur l'ensemble de la journée, mais pendant la période de production électrique effective, et donc nous retirons de l'estimations les horaires de nuit qui se situe selon les données observées de 21h à 6h. En effet, la production électrique pendant ces horaires est nulle et n'a pas besoin d'être estimée (on pourra se référer à la figure #ref(<fig:boxplot_pv_journee>)).

=== Estimation de la régularité locale et de la fonction moyenne

L'estimation des paramètres de régularité $H$ et $L$ qui varient sur le support nous permet d'une part de prendre en compte la régularité du processus pour l'estimation de la fonction moyenne, mais aussi d'autre part de pouvoir comparer la régularité de la production électrique lors de différentes saisons.
On remarque bien que la production d'électricité en moyenne est nettement inférieure en hiver qu'en été, en plus de voir le pic de production légèrement plus tôt en Hiver, peu après midi.
On constate de plus que la production électrique est bien plus irrégulière en hiver qu'en été comme on pouvait s'y attendre : Les valeurs de $H$ sont plus souvent en dessous de $0.5$ en hiver qu'en été et vartie fortement sur l'ensemble du support sans se stabiliser.

#figure(
  grid(
    columns: (1fr, 1fr),
    column-gutter: 0.5em,
    row-gutter: 0.5em,
    [
      #image("/src/Images/pv_estim/hiv_187128_Ht.jpg", width: 89%)
      #image("/src/Images/pv_estim/hiv_187128_Lt.jpg", width: 89%)
      #image("/src/Images/pv_estim/hiv_187128_mut.jpg", width: 89%)
    ],
    [
      #image("/src/Images/pv_estim/ete_187128_Ht.jpg", width: 89%)
      #image("/src/Images/pv_estim/ete_187128_Lt.jpg", width: 89%)
      #image("/src/Images/pv_estim/ete_187128_mut.jpg", width: 89%)
    ],
    align(center)[Hiver],
    align(center)[Été],
  ),
  caption: [Comparaison de l'estimation de la régularité et de la fonction moyenne sur les données photovoltaïques sur un même parc entre l'hiver et l'été],
  kind: image, supplement: [Figure],
) <fig:estim_reg_mu_hiv_ete>
