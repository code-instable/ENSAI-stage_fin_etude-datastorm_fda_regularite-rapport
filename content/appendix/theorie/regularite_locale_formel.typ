// ~ src/content/appendix/theorie/regularite_locale-formel.tex
#import "../../../lib/math.typ": *
#import "../../../lib/components.typ": brain, question, colorize
#import "../../../lib/theorems.typ": anchor

=== Définition formelle des fonctions Höldériennes sur un intervalle & régularité locale formellement

Il est important de se référer aux définitions formelles pour garder à l'esprit les propriétés des objets que l'on manipule. Voici en version formelle la différence entre les différents «#h(0.1em)modes de régularité#h(0.1em)» traîtés en section #ref(<sec:ce-qu-on-entend-par-reguarite-locale>) ( #h(0.2em) Ce qu'on entend par régularité locale #h(0.2em) )

#anchor("annexe:regularite-def")

- Continuité :

  $ (forall epsilon.alt > 0) thin (forall x in I) (exists delta_(colorize(x)) > 0) (forall y in I) thin abs(x-y) < delta_(colorize(x)) ==> abs(f(x) - f(y)) < epsilon.alt $

- Uniforme Continuité :

  $ (forall epsilon.alt > 0) thin (exists delta_(colorize(I)) > 0) (forall x,y in I) thin abs(x-y) < delta_(colorize(I)) ==> abs(f(x) - f(y)) < epsilon.alt $

- Lipschitz :

  $ exists L_I quad (forall x,y in I) quad abs(f(x) - f(y)) < L_I abs(x-y) $

- Hölder :

  $ exists alpha in (0,1] quad exists L_(alpha(I)) quad (forall x,y in I) quad abs(f(x) - f(y)) < L_(alpha(I)) abs(x-y)^alpha $

  #brain[
    une fonction lipschitz est une fonction Holderienne avec $alpha = 1$
  ]

- Localement Hölder :

  $ forall x_0 in I quad exists V in cal(V)(x_0) quad sans("tq ") exists alpha(V), L_(alpha(V)) quad cases(
      (forall x in V) quad abs(f(x) - f(x_0)) < L_(alpha(V)) abs(x-x_0)^(alpha(V)),
      quad 0 < alpha(V) lt.eq 1,
    ) $

  pour alléger les notations on mentionnera par abus de notation $alpha(x_0)$ et $L_(alpha(x_0))$ pour désigner $alpha(V)$ et $L_(alpha(V))$ avec $V in cal(V)(x_0)$

=== Des processus Höldériens ?

Nous avons mentionné que les processus auxquels on allait s'intéresser étaient les processus localement Höldériens de paramètres $(alpha(t), L_alpha (t))$. Ce n'est pas tout à fait vrai. Si le coeur de ce que l'on considère sont bel et bien les processus Höldériens, on élargit encore plus la classe des processus que l'on considère en considérant les processus qui sont *presque* Höldériens.

#question(align(center)[Qu'est ce qu'on entend exactement par presque Höldérien ?])

Ce que l'on demandait pour un processus $X$ est que pour tout $u,v$ dans un voisinage de $t$ de diamètre $Delta$, il existe $L_t$ et $H_t$ telle qu'on ait :

$ theta(u,v) isdef esperance(abs(X(u) - X(v))^2) lt.eq L_t^2 thin abs(u - v)^(2 H_t) $

On peut alors retrouver la régularité du processus comme un processus Höldérien de paramètres $(H_t, L_t)$ d'après le théorème de Continuité de Kolmogorov. En réalité il suffit que $theta(u,v)$ soit suffisamment proche d'un processus localement Höldérien de paramètres $(H_t, L_t)$ et que l'on puisse contrôler l'écart entre les deux. Cet écart dépend de $Delta$ et de la régularité. C'est ce qu'affirme les deux hypothèses suivantes qui sont en fait les hypothèses de régularité qui sont considérées par MPV#cite(<maissoro-SmoothnessFTSweakDep>).

$ abs(theta(u,v)-L_t^2 abs(u-v)^(2H_0)) lt.eq S_t^2 abs(u-v)^(2H_0) Delta^(2beta_0) quad quad #cite(<maissoro-SmoothnessFTSweakDep>, supplement: [H6]) $

$ abs(nu_2 (nabla^delta X(u)-nabla^delta X(v))^2-L_(delta,t)^2 abs(u-v)^(2H_delta)) lt.eq S_(delta,t)^2 abs(u-v)^(2H_delta) Delta^(2beta_delta) quad #cite(<maissoro-SmoothnessFTSweakDep>, supplement: [D1-7]) $

On remarquera que si le processus est localement Höldérien, alors on a un contrôle optimal de l'écart entre $theta(u,v)$ et $L_t^2 thin abs(u - v)^(2 H_t)$.

L'auteur saura donc reconnaître, que bien que ce qui ait été exposé ne soit pas la forme exacte, cela ne change rien à l'idée générale. De plus, cela alourdirait considérablement la rédaction et rendrait la compréhension bien plus difficile de l'objectif du stage.
