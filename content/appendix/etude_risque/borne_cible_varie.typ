// ~ src/content/appendix/borne_cible_varie.tex
#import "../../../lib/math.typ": *
#import "../../../lib/theme.typ": numeq
#import "../../../lib/theorems.typ": rem

Nous considérons le risque euclidien : $cal(R)(Theta, Delta) = bb(E) distnorme(2, hat(Theta), tilde(Theta))$. C'est un risque naturel à considérer pour une estimation conjointe de deux paramètres. Evidemment, nous ne disposons pas de la loi de $distnorme(2, hat(Theta), tilde(Theta))$ c'est pourquoi nous calculons $hat(cal(R))(Theta, Delta) = bb(E) distnorme(2, hat(Theta), tilde(Theta))$

Nous observons sur les différents graphes des risques de l'ordre de grandeur de $10^(-2)$ ou même de $10^(-3)$. La question que l'on se pose désormais est si il est raisonnable de penser que ne pas choisir le $Delta^*$ optimal n'est pas si important dans l'estimation du couple $Theta$.

Ce que nous allons observer est qu'il est tout de même préférable de bien déterminer le $Delta$

#math.equation(numbering: numeq, block: true, $ theta(u,v) = esperanceloi(X, abs(X(v) - X(u))^2) lt.eq L_(J(Delta))^2 abs(v - u)^(2 H_(J(Delta))) $)

sachant que l'on évalue :

#math.equation(numbering: numeq, block: true, $ sans("soit ") thetaA = vec(theta(t_1, t_3), theta(t_1, t_2)) $)
#math.equation(numbering: numeq, block: true, $ sans("soit ") thetaB = vec(theta(t_1, t_3), theta(t_2, t_3)) $)

avec :

#math.equation(numbering: numeq, block: true, $ abs(t_3 - t_1) &= Delta \
  abs(t_3 - t_2) &= Delta/2 = abs(t_2 - t_1) $) <eq:couples_diff_delta_value>

et donc :

#math.equation(numbering: numeq, block: true, $ norme(2, Theta) &= sqrt(theta_13^2 + theta_(12\/23)^2) \
  &lt.eq sqrt(L_(J(Delta))^4 (Delta^(4 H_(J(Delta))) [1 + 1/2])) \
  &= L_(J(Delta))^2 dot.op Delta^(2H_(J(Delta))) dot.op sqrt(3/2) $)

Et donc :

$ norme(2, Theta) lt.eq L_(J(Delta))^2 dot.op Delta^(2H_(J(Delta))) dot.op sqrt(3/2) $

On se réfère à ces bornes même si l'on étudie plutôt $tilde(Theta)$ car on peut se ramener asymptotiquement à $Theta$ par la loi des grands nombres grâce à la dépendance faible :

#math.equation(numbering: numeq, block: true, $ norme(2, tilde(Theta)) &= norme(2, 1/N sum_(i=1)^N vec(abs(X_i (t_3) - X_i (t_1))^2, abs(X_i (t_3) - X_i (t_2))^2)) \
  &#cv-arrow($sans("LGN + dep. faible + norme ") cal(C)^0 (RR(2))$, $N arrow.r infinity$) norme(2, Theta) lt.eq L_(J(Delta))^2 dot.op Delta^(2H_(J(Delta))) dot.op sqrt(3/2) $)

#rem[
  On peut remplacer le couple $(t_2, t_3)$ par $(t_1, t_2)$ dans la deuxième composante, l'argument reste valide, comme explicité dans l'équation #ref(<eq:couples_diff_delta_value>)
]

En utilisant les données de la simulation, $L = 1$, on obtient :

#math.equation(numbering: numeq, block: true, $ H_(J(Delta)) = 0.4 &==> norme(2,Theta) cases(lt.tilde 3 dot.op 10^(-2) quad Delta = 0.01, lt.tilde 3 dot.op 10^(-1) quad Delta = 0.2) \
  H_(J(Delta)) = 0.5 &==> norme(2,Theta) cases(lt.tilde 1 dot.op 10^(-2) quad Delta = 0.01, lt.tilde 2 dot.op 10^(-1) quad Delta = 0.2) \
  H_(J(Delta)) = 0.6 &==> norme(2,Theta) cases(lt.tilde 5 dot.op 10^(-3) quad Delta = 0.01, lt.tilde 2 dot.op 10^(-1) quad Delta = 0.2) \
  H_(J(Delta)) = 0.73 &==> norme(2,Theta) cases(lt.tilde 1 dot.op 10^(-3) quad Delta = 0.01, lt.tilde 1 dot.op 10^(-1) quad Delta = 0.2) $)

Ainsi, la différence de risque entre l'optimum et le pire cas étant de l'odre de $10^(-2)$ dans un cas très sparse comme dans la figure #ref(<fig:sparse_osef>) et dans un cas raisonnablement dense on observe même des différences de l'ordre de $10^(-3)$ pour le plus régulier.

#figure(
  table(
    columns: (auto, auto, 1fr, 1fr, auto),
    align: (center + horizon, center + horizon, center + horizon, center + horizon, center + horizon),
    stroke: 0.5pt,
    inset: (x: 6pt, y: 5pt),
    table.hline(stroke: 1pt),
    table.header(
      [*H*], [$bold(lambda)$], [*Différence : * $bold(cal(R)_(m a x) - cal(R)_(m i n))$],
      [ordre de gradeur de la borne de $norme(2, Theta)$], [${norme(2, Theta)}^2$],
    ),
    table.hline(stroke: 0.6pt),
    [0.51], [60], [3.3 $dot.op 10^(-2)$], [$Delta^* approx 0.2$ : $10^(-1)$], [$10^(-2)$],
    [0.51], [210], [1.1 $dot.op 10^(-2)$], [$Delta^* approx 0.2$ : $10^(-1)$], [$10^(-2)$],
    table.hline(stroke: 0.6pt),
    [0.6], [60], [4.2 $dot.op 10^(-2)$], [$Delta^* approx 0.01$ : $10^(-3)$], [$10^(-6)$],
    [0.6], [210], [1.2 $dot.op 10^(-2)$], [$Delta^* approx 0.01$ : $10^(-3)$], [$10^(-6)$],
    table.hline(stroke: 0.6pt),
    [0.73], [60], [1.2 $dot.op 10^(-2)$], [$Delta^* approx 0.01$ : $10^(-3)$], [$10^(-6)$],
    [0.73], [210], [5.4 $dot.op 10^(-3)$], [$Delta^* approx 0.01$ : $10^(-3)$], [$10^(-6)$],
    table.hline(stroke: 1pt),
  ),
  caption: [Ordre de grandeur des différences entre le risque euclidien minimum et maximum pour $Delta in [0.01, 0.2]$ et la norme de la cible],
  kind: table, supplement: [Table],
) <tab:ordre_grandeur_diff_R_norme>

Étant donné que le risque utilisé est homogène à la norme euclidienne au carré, on ne peut dire, du point de vue du risque euclidien, que l'on peut prendre n'importe quel $Delta$ dans $[0.01, 0.2]$ sans trop de conséquences.
Ce tableau vient motiver la section suivante sur le choix du risque à considérer pour la détermination d'un $Delta$ optimal. Si la norme de notre cible varie avec $Delta$, une idée est de plutôt considérer la qualité de l'estimation, relativement à la norme de la cible.
