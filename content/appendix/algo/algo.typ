// ~ src/content/appendix/algo/algo.tex
// (algorithm2e pseudocode, ported with the lovelace package; the two other
// files \input from src/content/appendix/chap_algo.tex's sibling directory,
// code.tex and fda_code_R.tex, are excluded — both sit behind
// \ifnum\value{code}=1 resp. are simply never \input anywhere, and
// fda_code_R.tex's own \chapter{FDA pour le praticien} does not appear
// anywhere in out/rapport.pdf, confirming it is dead content)
#import "@preview/lovelace:0.3.1": pseudocode, indent
#import "../../../lib/math.typ": *

#let comment(body) = text(fill: gray, style: "italic", size: 0.9em, [#h(1fr) \# #body])

#let tlnm = $T^([lambda])_n [m]$
#let mset = intervaleint(1, $M_n$)
#let nset = intervaleint(1, $N$)
#let lbdset = $lr(⟦ 30, 45, dots.c , 480 ⟧)$
#let genxset = $(#tlnm, X_n (#tlnm))_(m in #mset)$
#let simset = ${ #genxset : n in #nset, lambda amp N sans(" fixés ") }$
#let simsetall = ${ #genxset : N in arrow(N), lambda in #lbdset, n in #nset }$

#figure(
  pseudocode(
    line-numbering: "1",
    title: none,
    [*Input:*],
    indent(
      [$arrow(t)$ : endroits où évaluer la régularité],
      [Régularité de $X_n$ sur $[0,1]$ : $H : t |-> H_t$],
      [fonction moyenne : $mu$],
    ),
    [*Output:* $L = {L[N,lambda] : N in arrow(N), lambda in lbdset, n in nset}$],
    [*Result:* $simsetall$],
    [$G arrow.l 100$ #comment[Grille d'approximation de l'$integral$]],
    [$B arrow.l 100$ #comment[Burn-in de la relation FAR(1)]],
    [$arrow(Delta) arrow.l [0.01 dots.c 0.2]_30$ #comment[diamètre du voisinage $J_Delta$]],
    [$arrow(N) arrow.l [100, 200, 300, 400]_4$ #comment[nombre de courbes]],
    [$Lambda arrow.l [30, 45, dots.c, 480]$ #comment[nombre moyen de points observés sur une courbe]],
    [$L = [thin thin]$],
    [*for* $N in arrow(N)$ *do* #comment[$arrow(N) = [100, 200, 300, 400]$]],
    indent(
      [*for* $lambda in Lambda$ *do*],
      indent(
        [$genxset arrow.l op("far_sim")(N, lambda, H, mu, B, G, arrow(t), arrow(Delta))$ #comment[génération]],
      ),
      [*end*],
      [$L[N,lambda] arrow.l genxset$],
    ),
    [*end*],
    [*return* $L$],
  ),
  caption: [$op("Get_single_mc_sim")$ : Génération de FAR pour chaque valeur sur la grille],
  kind: "algorithm", supplement: [Algorithm], numbering: "1",
) <alg:gen_far_grid>

#figure(
  pseudocode(
    line-numbering: "1",
    title: none,
    [*Input:*],
    indent(
      [$N in bb(N)^*$ : nb $X_n$],
      [$lambda in bb(N)^*$ : nb moy pts observés],
      [$H : t |-> H_t$ : régularité],
      [$mu : [0,1] arrow.r bb(R)$ : moyenne],
      [$B in bb(N)^*$ : Burn-in du FAR(1)],
      [$G in bb(N)^*$ : grille méthode des rectangles],
      [$arrow(Delta)$ : tous les diamètres testés],
      [$arrow(t)$ : endroits où évaluer la régularité],
    ),
    [*Result:* $simset$ #linebreak() avec $X_(n+1)(t) = integral beta(u,t) X_n (t) + eta_(n+1)$],
    [$N_t arrow.l op("len")(arrow(t))$],
    [$N_(c a l c) arrow.l N + B$],
    [$T(Delta) = mat(t_1[1] = arrow(t)[1] - Delta/2, t_2[1] = arrow(t)[1], t_3[1] = arrow(t)[1] + Delta/2; dots.v, dots.v, dots.v; t_1[N_t] = arrow(t)[N_t] - Delta/2, t_2[N_t] = arrow(t)[N_t], t_3[N_t] = arrow(t)[N_t] + Delta/2)$ #comment[points de comparaison avec le lissage]],
    [$T_(o b s) arrow.l cal(U)([0,1])^(⊗ lambda)$ #comment[Points observés]],
    [$sans("grid")_integral arrow.l ((k-1+k)/2)_(k in intervaleint(1,G))$ #comment[Grille de la méthode des rectangles médians]],
    [$T arrow.l T_(o b s) union T(Delta) union sans("grid")_integral$ #comment[Ensemble des points]],
    [$T arrow.l op("order")(T)$],
    [$L = [thin thin]$ #comment[Simulation de mouvement brownien multi fractionnaire de régularité $(H,L)$]],
    [*for* $k in intervaleint(1,N_(c a l c))$ *do*],
    indent(
      [$epsilon.alt_k arrow.l op("mfBm_sim")(T, H, L)$],
      [$mu_k arrow.l mu(T)$],
      [$L[k] arrow.l mat(T, epsilon.alt_k, mu_k)$ #comment[$in cal(M)_(op("len")T, 3) (bb(R))$]],
    ),
    [*end*],
    [*for* $k in intervaleint(1,N_(c a l c))$ *do* #comment[$X_(n+1)(t) = mu(t) + display(integral_0^1) beta(u,t) X_n (u) d u + epsilon.alt_(n+1)$]],
    indent(
      [$K_beta = mat(dots.down, dots.v, rddots; dots.h, beta(s,t), dots.h; rddots, dots.v, dots.down)$],
      [$I(beta, bb(X)_(k-1)) = 1/G K_beta bb(X)_(k-1)$],
      [$bb(X)_k arrow.l mu_k + I(beta, bb(X)_(k-1)) + epsilon.alt_k$],
    ),
    [*end*],
    [*return* $(bb(X)_n)_(n in intervaleint(B+1,N_(c a l c)))$],
  ),
  caption: [$op("far_sim")$ : Simulation d'un $op("FAR")(1)$],
  kind: "algorithm", supplement: [Algorithm], numbering: "1",
) <alg:far_sim>
