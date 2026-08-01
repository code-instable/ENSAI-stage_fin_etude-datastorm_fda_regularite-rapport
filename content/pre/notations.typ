// ~ src/content/pre/notations/main.tex
#import "../../lib/math.typ": *
#import "../../lib/components.typ": colorize
#import "../../lib/theme.typ": flat

#let notations-table(..rows) = table(
  columns: (auto, 1fr),
  stroke: none,
  align: (x, y) => if x == 0 { left + horizon } else { left + horizon },
  inset: (x: 6pt, y: 5pt),
  table.hline(stroke: 1pt),
  table.header([*Notation*], [*Signification*]),
  table.hline(stroke: 0.6pt),
  ..rows,
  table.hline(stroke: 1pt),
)

#let section-row(body) = table.cell(colspan: 2, strong(body))

#let notations() = [
  #text(size: 16pt, weight: "bold")[Notations] <table-notations>
  #v(1em)

  #notations-table(
    section-row[Abréviations], table.hline(stroke: 0.6pt),
    [CDC], [Courbe de Charge],
    [FDC], [Facteur de Charge],
    [MPV], [Maissoro - Patilea - Vimond],
    [FDA], [Analyse de Données Fonctionnelles (Functional Data Analysis)],
    [FPCA], [Analyse par Composantes Principales Fonctionnelle(Functional Principal Component Analysis)],
    [KL], [Karhunen-Loève],
    table.hline(stroke: 0.6pt),
    section-row[Analyse], table.hline(stroke: 0.6pt),
    $x_0$, [Une valeur spécifique de $x$],
    $V in cal(V)(x_0)$, [Un voisinage de $x_0$],
    $cal(C)^0 (E, F)$, [Fonction continue de $E$ dans $F$],
    $cal(H)_(cal(V)(x_0)) (alpha_(x_0), L_(alpha_(x_0)))$, [Classe de Hölder de paramètre $alpha_(x_0), L_(alpha_(x_0))$ sur un voisinage de $x_0$],
    $op("mfBm")(H, L)$, [Ensemble des mouvements browniens multi-fractionnaires de fonction de Hurst $H : t |-> H_t$ et constante de Hölder locale $L : t |-> L_t$ : ce sont les «#h(0.1em)paramètres de Hölder#h(0.1em)» des mouvements browniens considérés.],
    table.hline(stroke: 0.6pt),
    section-row[Algèbre], table.hline(stroke: 0.6pt),
    $Sp(phi, field: bb(K))$, [Valeurs propres d'un opérateur ou endomorphisme linéaire $phi$ sur le corps $bb(K)$],
    $Sp(phi)$, [Valeurs propres d'un opérateur ou endomorphisme linéaire $phi$ sous-entendu sur le corps $bb(R)$],
    $arrow(op("sp"))_(orthonormal) (phi)$, [Vecteurs propres d'un opérateur ou endomorphisme linéaire $phi$ formant une famille orthogonale],
    $arrow(op("sp"))_(orthonormal)^([1,p]) (phi)$, [$p$ premiers vecteurs propres d'un opérateur ou endomorphisme linéaire $phi$ formant une famille orthogonale],
    table.hline(stroke: 0.6pt),
    section-row[Statistique], table.hline(stroke: 0.6pt),
    $X$, [La «#h(0.1em)vraie#h(0.1em)» distribution],
    $tilde(X)$, [Quantité intangible/inobservable],
    $hat(X)$, [Un estimation empirique X],
    $ordered(X, k)$, [Statistique d'ordre de $X$, $k^("eme")$ terme : $ordered(X, k) lt.eq ordered(X, k+1)$],
    $statrang(Y, n, k)$, [Valeur observée au $k^("eme")$ temps (au sens de la relation d'ordre $lt.eq$ ) sur le support du processus $X_n$ : $statrang(Y, n, k) isdef X_n (ordered(T, k)) + eta_n [k]$],
    table.hline(stroke: 0.6pt),
    section-row[Probabilités], table.hline(stroke: 0.6pt),
    $C_X (s,t)$, [Covariance du processus $X$ entre le temps $s$ et le temps $t$],
    $c [ f ]$, [Opérateur de covariance évalué en $f$],
    $VA(E)$, [Variable aléatoire à valeur dans $E$ : $VA(E) isdef bold(m) ((Omega, cal(F), bb(P)) , (E, cal(A), mu))$],
  )

  #v(1em)

  #notations-table(
    section-row[Spécifique au stage], table.hline(stroke: 0.6pt),
    $xi$, [Bruit blanc gaussien provenant d'un mouvement Brownien multi-fractionnaire],
    $eta$, [Bruit blanc gaussien provenant de l'erreur de mesure],
    table.hline(stroke: 0.6pt),
    $M_n$, [Nombre de points observés sur la trajectoire de la donnée fonctionnelle $X_n$],
    $N$, [Nombre de courbes observées],
    table.hline(stroke: 0.6pt),
    $lambda$, [$esperance(M_n)$ ( $M_n tilde cal(P)(lambda)$ )],
    $hat(lambda)$, [Nombre moyen de points observés par courbe : $hat(lambda) = 1/N sum_(i=1)^N M_i$],
    table.hline(stroke: 0.6pt),
    section-row[Temps particuliers ($t in cal(T)$)], table.hline(stroke: 0.6pt),
    $cal(T)$, [Support du processus $X$, ici $cal(T) = [0,1]$],
    $T_n [m]$, [$m^("eme")$ temps ( du $m^("eme")$ sampling du phénomène aléatoire ) observé sur la trajectoire de la donnée fonctionnelle $X_n$],
    $T_n^((m))$, [$m^("eme")$ temps (au sens de la relation d'ordre $lt.eq$ ) observé sur la trajectoire de la donnée fonctionnelle $X_n$],
    $t_0$ + [ ou ] + $t_2$, [Point où l'on souhaite estimer la régularité, $t_0$ est plus courant comme notation pour fixer un point mais $t_2$ est utilisé dans l'implémentation pour signaler sa centralité sur $J_Delta$],
    $J_Delta (t_0)$, [«#h(0.1em)voisinage#h(0.1em)» du point $t_0$ que l'on utilise pour estimer la régularité, implémenté comme l'intervalle $[t_1, t_3]$],
    $t_1 (Delta)$, [$t_2 - Delta/2$ | lorsque $Delta$ est quelconque, abbrégé en $t_1$],
    $t_3 (Delta)$, [$t_2 + Delta/2$ | lorsque $Delta$ est quelconque, abbrégé en $t_3$],
    $g_k$, [Point de la grille du calcul numérique d'une intégrale, $k in intervaleint(1, G)$],
    table.hline(stroke: 0.6pt),
    $phi.alt$, [Relation auto-régressive intégrale],
    $beta$, [Noyau de l'opérateur intégral],
    table.hline(stroke: 0.6pt),
    $theta(u,v)$, [$= esperance(abs(X(v) - X(u))^2)$],
    table.hline(stroke: 1pt),
    section-row[Utilisés dans les algorithmes], table.hline(stroke: 0.6pt),
    $bb(T)$, [Ensemble des points générés dans la simulation du mouvement brownien multi-fractionnaire : points observés (aléatoire), point de la grille d'approximation de l'intégrale de la relation FAR, points utilisés pour l'estimation de la régularité locale],
    $B$, [Nombre de burn-in pour atteindre la stationnarité du FAR],
    $G$, [Nombre de points de la grille du calcul numérique d'une intégrale],
    table.hline(stroke: 0.6pt),
    $cal(R)^(["rel"\/"abs"])_(m c) (Delta, Theta)$, [Risque pour une réplication de Monte-Carlo du couple $Theta$ : $cal(R)^(["rel"])_(m c) (Delta, Theta) = distnorme(2, hat(Theta), tilde(Theta))/norme(2, Theta)$ et $cal(R)^(["abs"])_(m c) (Delta, Theta) = distnorme(2, hat(Theta), tilde(Theta))$],
    $cal(R)^(["rel"\/"abs"])_(m c thin colorize(p, color: flat.blue)) (Delta, Theta)$, [Risque pour la $p^("eme")$ réplication de Monte-Carlo de la simulation],
    table.hline(stroke: 0.6pt),
    $cal(R)^(["rel"\/"abs"]) (Delta, Theta)$, [Risque d'estimation du couple d'incréments pour des réplications indépendantes (de Monte-Carlo) : $cal(R)^(["rel"\/"abs"]) (Delta, Theta) = esperanceloi(p, cal(R)^(["rel"\/"abs"])_(m c thin [p]) (Delta, Theta))$],
    $hat(cal(R))^(["rel"\/"abs"]) (Delta, Theta)$, [Estimation du risque d'estimation du couple d'incréments par la moyenne empirique $1/(m c) sum_(p=1)^(m c) cal(R)^(["rel"\/"abs"])_(m c thin [p]) (Delta, Theta)$],
  )
]
