// ~ src/content/appendix/risque/h_glob_indiv/{h_glob_vs_indiv_txt,h_glob_vs_indiv_tables,glob_indiv_table_1,glob_indiv_table_2,glob_indiv_table_3}.tex
// (h_glob_vs_indiv_tables_comments.tex is excluded: it is 100% LaTeX comments,
// raw R console output kept as notes by the author, contributing no rendered
// content)
#import "../../../lib/math.typ": *
#import "../../../lib/components.typ": warn, question, chk, blackboxed, circled
#import "../../../lib/theorems.typ": leftbar

=== Rappel de la méthodologie utilisée

Afin de simplifier les notations, dans la suite nous nous référons à 2 cas de méthodologie différentes nommées «#h(0.1em)*individuel*#h(0.1em)» et «#h(0.1em)*global*#h(0.1em)». Cependant le nom choisi ne reflète pas entièrement la procédure, il faut donc bien garder en tête ce qu'on attend par ces noms de méthodologie :

#figure(
  table(
    columns: (auto, 1fr, 1fr),
    align: (left + horizon, left + horizon, left + horizon),
    stroke: 0.5pt,
    inset: (x: 8pt, y: 6pt),
    table.header([threshold/méthodologie], [*individuel*], [*global*]),
    table.hline(stroke: 1pt),
    $lambda < 110$, [$h$ cross-validé *par courbe*], [$h$ cross-validé *par courbe*],
    table.hline(stroke: 0.6pt),
    $lambda gt.eq 110$, [$h$ cross-validé *par courbe*], [détermination de 50 fenêtres $h_i$ cross-validées sur les 50 premières courbes puis utilise $h = limits(op("med"))_(i in intervaleint(1,50)) h_i^(*-sans("cv"))$ sur *toutes les courbes*],
  ),
  caption: [Différences entre la méthode de lissage «#h(0.1em)individuelle#h(0.1em)» et «#h(0.1em)globale#h(0.1em)»],
  kind: table, supplement: [Table], outlined: false,
)

Ce rappel sera important dès la prochaine section portant sur le comportement du cas sparse.

=== Le cas sparse <annexe:lissage_fail>

les tables #ref(<tab:couple_1312_indiv_vs_glob>) et #ref(<tab:couple_1323_indiv_vs_glob>) indiquent que la différence en terme de performance sur le Risque entre un lissage global (déterminé comme la médiane des fenêtres cross-validées sur les 50 premières courbes) et un lissage individuel (la fenêtre de lissage de chaque courbe est déterminée par validation croisée) devient mineure une fois que le nombre moyen de points par courbe devient «#h(0.1em)dense#h(0.1em)». Dans notre cas, on voit qu'à partir de $lambda = 150$, la différence entre la médiane du risque par lissage à fenêtre globale et par lissage individuel devient faible (de l'ordre de $10^(-6)$ à $10^(-3)$) et une différence de variance presque imperceptible (de l'ordre de $10^(-9)$ à $10^(-5)$).

#warn[A la vue de ces résultats il semblerait que la conclusion évidente soit de faire une fenêtre cross-validée individuelle lorsque l'on est dans un cas sparse. Sauf qu'il ne faut pas oublier que dans l'appellation «#h(0.1em)global#h(0.1em)» comme mentionné précédemment, les différentes courbes étaient déjà lissées individuellement lorsque $lambda < 110$.]

#question[D'où viennent alors de telles différences ?]

Un changement d'algorithme a été opéré entre les lissages effectués avec la méthode «#h(0.1em)globale#h(0.1em)» (première méthode utilisée) et la méthode «#h(0.1em)individuelle#h(0.1em)» : lorsqu'il existe un endroit où on lisse pour déterminer la régularité tel qu'il n'y a pas assez de points autour, on ne sélectionne pas la fenêtre associée.

Sous R, entre autre, l'implémentatione st telle que si le lissage à noyau renvoie `NaN`, on ne choisit pas le $h$ associé :

```R
cv_error <- sapply(h_grid, function(hi, y, t, K) {
	yhat <- estimate_nw(y = y, t = t, h = hi, tnew = t, smooth_ker = K)$yhat
	wmat <- outer(X = t, Y = t, function(u, v) K((u - v) / hi))
	metric <- (y - yhat) / (1 - K(0) / rowSums(wmat))

	# If there is only one value in the kernel support, it return NaN.
	error_hi <- mean(metric[!is.nan(metric)]**2)
}, y = y, t = t, K = smooth_ker)

# If cv_error is NaN, do take it into account
if (any(is.nan(cv_error))) {
	h_grid <- h_grid[-which(is.nan(cv_error))]
	cv_error <- cv_error[!is.nan(cv_error)]
	hcv <- h_grid[which.min(cv_error)]
}
```

#chk[#circled[1] Il semblerait donc que cette différence de traîtement du nombre de points autour des points lissés soit ce qui explique la différence entre les deux méthodes pour le cas sparse, ce qui semble raisonnable : on ne voit pas de différence dans le cas dense simplement car ne pas avoir suffisamment de points autour se rarifie extrêment.]

#chk[#circled[2] On notera tout de même que la faible différence de médiane et de variance entre le cas «#h(0.1em)global#h(0.1em)» et «#h(0.1em)individuel#h(0.1em)» indique qu'il est possible d'économiser en temps de calcul sur des données même corrélées en calculant une fenêtre globale à partir des premières courbes lorsque l'on dispose d'observations denses à moindre coût sur le risque.]

=== Densité de points sur les courbes observées

==== Densité moyenne

Les figures #ref(<fig:den_ex>) et #ref(<fig:den_counterex>) affichent la densité de points présents autour de $t_2 = 0.8$ en considérant toutes les courbes pour un individu de monte-carlo associé à un risque extrême. En utilisant un estimateur de Parzen-Rosenblatt de fenêtre $Delta$ utilisé pour calculer $X(thin t_1 (Delta) thin)$ et $X(thin t_3 (Delta) thin)$ :

$ hat(f)_T = 1/N sum_(i=1)^N 1/M_i sum_(m=1)^(M_i) 1/Delta K((t - T_i [thin m thin])/Delta) $

De ces figures on peut déduire les conclusions suivantes : il semblerait que l'affichage de la densité de points autour du point problématique indique que les valeurs de risque extrêmes interviennent lorsqu'il existe peu ou pas de points sur l'ensemble des courbes en $t_1$ ou $t_3$. Toutefois, on pourra fournir en contre-exemple la figure #ref(<fig:den_counterex>), qui indique dans un rayon $Delta$ une densité constante de points (ce qui est en accord avec une simulation uniforme de points sur $cal(T)$ lorsque le nombre moyen de points par courbe devient relativement dense : $lambda = 210$).

#pagebreak(weak: true)

=== couple $Theta$ : $1 arrow.r 3$ / $1 arrow.r 2$

#figure(
  table(
    columns: (auto, auto, auto, auto, 1fr, auto, 1fr, auto),
    align: (center + horizon, center + horizon, center + horizon, center + horizon, center + horizon, center + horizon, center + horizon, center + horizon),
    stroke: 0.5pt,
    inset: (x: 5pt, y: 4pt),
    table.header(
      $t$, $H_t$, $N$, $lambda$,
      [différence $op("med") cal(R)^([sans("abs")])_(m c) (Theta, Delta)$], [*meilleur*],
      [différence $bb(V) cal(R)^([sans("abs")])_(m c) (Theta, Delta)$], [*meilleur*],
    ),
    table.hline(stroke: 1pt),
    [0.3], [0.51], [$dots.v$], [$dots.v$], [7.26], [indiv], [8.36], [indiv],
    [0.4], [0.55], [$dots.v$], [$dots.v$], [6.31], [indiv], [6.91], [indiv],
    [0.5], [0.60], [$dots.v$], [$dots.v$], [2.32], [indiv], [0.07], [indiv],
    [0.6], [0.65], [200], [45], [0.09], [indiv], [13.68], [global],
    [0.7], [0.69], [$dots.v$], [$dots.v$], [0.01], [indiv], [15.70], [global],
    [0.8], [0.73], [$dots.v$], [$dots.v$], [0.22], [indiv], [0.02], [indiv],
    table.hline(stroke: 0.6pt),
    [0.3], [0.51], [$dots.v$], [$dots.v$], [0.72], [indiv], [0.32], [indiv],
    [0.4], [0.55], [$dots.v$], [$dots.v$], [0.79], [indiv], [0.36], [indiv],
    [0.5], [0.60], [$dots.v$], [$dots.v$], [0.29], [indiv], [0.04], [indiv],
    [0.6], [0.65], [200], [90], [0.01], [indiv], [9.93], [global],
    [0.7], [0.69], [$dots.v$], [$dots.v$], [$2 dot.op 10^(-3)$], [indiv], [$5 dot.op 10^(-6)$], [indiv],
    [0.8], [0.73], [$dots.v$], [$dots.v$], [0.03], [indiv], [$2 dot.op 10^(-3)$], [indiv],
    table.hline(stroke: 0.6pt),
    [0.3], [0.51], [$dots.v$], [$dots.v$], [$1 dot.op 10^(-3)$], [global], [$1 dot.op 10^(-5)$], [indiv],
    [0.4], [0.55], [$dots.v$], [$dots.v$], [$3 dot.op 10^(-3)$], [global], [$9 dot.op 10^(-5)$], [global],
    [0.5], [0.60], [$dots.v$], [$dots.v$], [$3 dot.op 10^(-5)$], [global], [$7 dot.op 10^(-6)$], [global],
    [0.6], [0.65], [200], [150], [$4 dot.op 10^(-6)$], [global], [$1 dot.op 10^(-7)$], [global],
    [0.7], [0.69], [$dots.v$], [$dots.v$], [$1 dot.op 10^(-6)$], [indiv], [$1 dot.op 10^(-8)$], [global],
    [0.8], [0.73], [$dots.v$], [$dots.v$], [$9 dot.op 10^(-6)$], [indiv], [$4 dot.op 10^(-6)$], [global],
    table.hline(stroke: 0.6pt),
    [0.3], [0.51], [$dots.v$], [$dots.v$], [$4 dot.op 10^(-3)$], [indiv], [$3 dot.op 10^(-5)$], [global],
    [0.4], [0.55], [$dots.v$], [$dots.v$], [$2 dot.op 10^(-3)$], [indiv], [$3 dot.op 10^(-6)$], [indiv],
    [0.5], [0.60], [$dots.v$], [$dots.v$], [$5 dot.op 10^(-5)$], [global], [$5 dot.op 10^(-7)$], [global],
    [0.6], [0.65], [200], [270], [$2 dot.op 10^(-4)$], [global], [$2 dot.op 10^(-7)$], [global],
    [0.7], [0.69], [$dots.v$], [$dots.v$], [$4 dot.op 10^(-4)$], [global], [$4 dot.op 10^(-6)$], [global],
    [0.8], [0.73], [$dots.v$], [$dots.v$], [$2 dot.op 10^(-4)$], [global], [$2 dot.op 10^(-7)$], [indiv],
    table.hline(stroke: 0.6pt),
    [0.3], [0.51], [$dots.v$], [$dots.v$], [$5 dot.op 10^(-3)$], [indiv], [$7 dot.op 10^(-5)$], [global],
    [0.4], [0.55], [$dots.v$], [$dots.v$], [$1 dot.op 10^(-3)$], [indiv], [$4 dot.op 10^(-6)$], [indiv],
    [0.5], [0.60], [$dots.v$], [$dots.v$], [$7 dot.op 10^(-5)$], [indiv], [$1 dot.op 10^(-7)$], [indiv],
    [0.6], [0.65], [200], [405], [$6 dot.op 10^(-5)$], [global], [$5 dot.op 10^(-9)$], [global],
    [0.7], [0.69], [$dots.v$], [$dots.v$], [$6 dot.op 10^(-5)$], [global], [$5 dot.op 10^(-9)$], [global],
    [0.8], [0.73], [$dots.v$], [$dots.v$], [$6 dot.op 10^(-5)$], [global], [$3 dot.op 10^(-9)$], [indiv],
    table.hline(stroke: 1pt),
  ),
  caption: [Comparaison de la médiane et de la variance du risque euclidien (absolu) entre lissage global et lissage individuel],
  kind: table, supplement: [Table],
) <tab:couple_1312_indiv_vs_glob>

=== couple $Theta$ : $1 arrow.r 3$ / $2 arrow.r 3$

#figure(
  table(
    columns: (auto, auto, auto, auto, 1fr, auto, 1fr, auto),
    align: (center + horizon, center + horizon, center + horizon, center + horizon, center + horizon, center + horizon, center + horizon, center + horizon),
    stroke: 0.5pt,
    inset: (x: 5pt, y: 4pt),
    table.header(
      $t$, $H_t$, $N$, $lambda$,
      [différence $op("med") cal(R)^([sans("abs")])_(m c) (Theta, Delta)$], [*meilleur*],
      [différence $bb(V) cal(R)^([sans("abs")])_(m c) (Theta, Delta)$], [*meilleur*],
    ),
    table.hline(stroke: 1pt),
    [0.3], [0.51], [$dots.v$], [$dots.v$], [7.37], [indiv], [8.20], [indiv],
    [0.4], [0.55], [$dots.v$], [$dots.v$], [6.12], [indiv], [7.44], [indiv],
    [0.5], [0.60], [$dots.v$], [$dots.v$], [3.80], [indiv], [0.84], [global],
    [0.6], [0.65], [200], [45], [0.02], [indiv], [14.35], [global],
    [0.7], [0.69], [$dots.v$], [$dots.v$], [$1 dot.op 10^(-2)$], [indiv], [15.33], [global],
    [0.8], [0.73], [$dots.v$], [$dots.v$], [9.90], [indiv], [0.13], [indiv],
    table.hline(stroke: 0.6pt),
    [0.3], [0.51], [$dots.v$], [$dots.v$], [7.19], [indiv], [3.40], [indiv],
    [0.4], [0.55], [$dots.v$], [$dots.v$], [7.46], [indiv], [2.90], [indiv],
    [0.5], [0.60], [$dots.v$], [$dots.v$], [6.37], [indiv], [0.59], [indiv],
    [0.6], [0.65], [200], [90], [$5 dot.op 10^(-3)$], [indiv], [10.53], [global],
    [0.7], [0.69], [$dots.v$], [$dots.v$], [$2 dot.op 10^(-3)$], [indiv], [$5 dot.op 10^(-6)$], [indiv],
    [0.8], [0.73], [$dots.v$], [$dots.v$], [$1 dot.op 10^(-1)$], [indiv], [$8 dot.op 10^(-3)$], [indiv],
    table.hline(stroke: 0.6pt),
    [0.3], [0.51], [$dots.v$], [$dots.v$], [$1 dot.op 10^(-3)$], [global], [$2 dot.op 10^(-5)$], [indiv],
    [0.4], [0.55], [$dots.v$], [$dots.v$], [$3 dot.op 10^(-5)$], [global], [$2 dot.op 10^(-4)$], [global],
    [0.5], [0.60], [$dots.v$], [$dots.v$], [$2 dot.op 10^(-5)$], [indiv], [$6 dot.op 10^(-6)$], [indiv],
    [0.6], [0.65], [200], [150], [$4 dot.op 10^(-6)$], [global], [$1 dot.op 10^(-7)$], [indiv],
    [0.7], [0.69], [$dots.v$], [$dots.v$], [$1 dot.op 10^(-5)$], [global], [$2 dot.op 10^(-8)$], [indiv],
    [0.8], [0.73], [$dots.v$], [$dots.v$], [$7 dot.op 10^(-6)$], [indiv], [$3 dot.op 10^(-6)$], [indiv],
    table.hline(stroke: 0.6pt),
    [0.3], [0.51], [$dots.v$], [$dots.v$], [$2 dot.op 10^(-3)$], [indiv], [$1 dot.op 10^(-5)$], [indiv],
    [0.4], [0.55], [$dots.v$], [$dots.v$], [$1 dot.op 10^(-3)$], [indiv], [$5 dot.op 10^(-6)$], [global],
    [0.5], [0.60], [$dots.v$], [$dots.v$], [$7 dot.op 10^(-5)$], [global], [$4 dot.op 10^(-7)$], [global],
    [0.6], [0.65], [200], [270], [$3 dot.op 10^(-4)$], [global], [$1 dot.op 10^(-7)$], [global],
    [0.7], [0.69], [$dots.v$], [$dots.v$], [$4 dot.op 10^(-4)$], [global], [$4 dot.op 10^(-6)$], [global],
    [0.8], [0.73], [$dots.v$], [$dots.v$], [$2 dot.op 10^(-4)$], [global], [$7 dot.op 10^(-8)$], [indiv],
    table.hline(stroke: 0.6pt),
    [0.3], [0.51], [$dots.v$], [$dots.v$], [$3 dot.op 10^(-3)$], [indiv], [$1 dot.op 10^(-5)$], [indiv],
    [0.4], [0.55], [$dots.v$], [$dots.v$], [$4 dot.op 10^(-4)$], [indiv], [$4 dot.op 10^(-6)$], [indiv],
    [0.5], [0.60], [$dots.v$], [$dots.v$], [$2 dot.op 10^(-5)$], [indiv], [$3 dot.op 10^(-7)$], [indiv],
    [0.6], [0.65], [200], [405], [$6 dot.op 10^(-5)$], [global], [$5 dot.op 10^(-9)$], [global],
    [0.7], [0.69], [$dots.v$], [$dots.v$], [$5 dot.op 10^(-5)$], [global], [$6 dot.op 10^(-9)$], [global],
    [0.8], [0.73], [$dots.v$], [$dots.v$], [$5 dot.op 10^(-5)$], [global], [$2 dot.op 10^(-8)$], [indiv],
    table.hline(stroke: 1pt),
  ),
  caption: [Comparaison de la médiane et de la variance du risque euclidien (absolu) entre lissage global et lissage individuel],
  kind: table, supplement: [Table],
) <tab:couple_1323_indiv_vs_glob>

#blackboxed[✎ Guide de lecture des deux tableaux précédents]

#leftbar[
  L'important ici est de constater qu'après les valeurs de $lambda = 90$, les différences entre la médiane et la variance des risques (absolus) est minime, ce qui serait d'ailleurs d'avantage accentué par une métrique qui écrase les valeurs proche de zéro comme une métrique quadratique. On peut donc s'économiser du temps de calcul en considérant quelques courbes, et en utilisant un $h$ par validation croisée sur les premières courbes et en l'appliquant aux autres données sans perte de qualité d'estimation importante.
]

#figure(
  table(
    columns: (1.6fr, 1fr, 1fr, auto, auto),
    align: (left + horizon, center + horizon, center + horizon, center + horizon, center + horizon),
    stroke: 0.5pt,
    inset: (x: 6pt, y: 5pt),
    table.header([statistique sur $hat(cal(R))_(m c)^([sans("abs")])$], [*Individuel*], [*Global*], $Delta$, $lambda$),
    table.hline(stroke: 1pt),
    [*min*], [0.000226], [0.338], [0.1], [$dots.v$],
    [*max*], [36.71], [2.448], [0.1], [60],
    [*quantile* $q_(97.5%)$], [0.0618], [1.862], [0.1], [$dots.v$],
    [*quantile* $q_(95%)$], [0.0457], [1.682], [0.1], [$dots.v$],
    table.hline(stroke: 0.6pt),
    [*min*], [$3.06 dot.op 10^(-6)$], [0.474], [0.015], [$dots.v$],
    [*max*], [83.53], [2.825], [0.015], [$dots.v$],
    [*quantile* $q_(97.5%)$], [0.00322], [1.909], [0.015], [60],
    [*quantile* $q_(95%)$], [0.00236], [1.794], [0.015], [$dots.v$],
    table.hline(stroke: 1pt),
    [*min*], [$4 dot.op 10^(-6)$], [$6 dot.op 10^(-6)$], [0.062], [$dots.v$],
    [*max*], [67.89], [0.01], [0.062], [210],
    [*quantile* $q_(97.5%)$], [$4.9 dot.op 10^(-3)$], [$4.6 dot.op 10^(-3)$], [0.062], [$dots.v$],
    [*quantile* $q_(95%)$], [$3.6 dot.op 10^(-3)$], [$3.5 dot.op 10^(-3)$], [0.062], [$dots.v$],
    table.hline(stroke: 1pt),
  ),
  caption: [Quelques statistiques sur la distribution du risque euclidien en fonction de la méthode de sélection de la fenêtre de lissage],
  kind: table, supplement: [Table],
) <tab:stat_R_eucl_min_max_q>
