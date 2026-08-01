// ~ src/content/chapter_3/pre_lissage.tex
#import "../../lib/math.typ": *
#import "../../lib/theme.typ": numeq

=== Les courbes obtenues

Voici l'exemple d'une courbe obtenue (courbe 1, 99#super[eme] simulation de monte-carlo) :

#figure(
  {
    align(center, strong[Données simulées])
    v(0.5em)
    grid(
      columns: (1fr, 1fr),
      column-gutter: 0.5em,
      image("/src/Images/simul/all.jpeg", width: 100%),
      image("/src/Images/simul/observed.jpeg", width: 100%),
    )
    v(0.7em)
    align(center, strong[Lissage des données])
    v(0.5em)
    image("/src/Images/simul/smoothed.jpeg", width: 96%)
  },
  caption: [Visualisation des données générées : $lambda = 255, N = 200,$ 30 valeurs de $Delta$],
  kind: image, supplement: [Figure],
)

=== Pré-Lissage

Le pré-lissage des courbes a été fait en utilisant un lissage non paramétrique à noyaux#footnote[Il était aussi prévu d'effectuer un pré-lissage spline et à ondelettes mais le temps a eu raison de ce projet]. Comme mentionné dans la section #ref(<eq:h_cross_noyau_pre>), chaque courbe est lissée en utilisant une fenêtre par validation croisée avec la grille $cal(H) = {0.01 dots 0.2}_50$ avec pour métrique une estimation du risque quadratique $esperance(abs(hat(Y)_((-i)) - Y)^2)$. On ne regarde pas de fenêtre au delà de $Delta = 0.2$ car il serait difficile de justifier pour l'estimation de la régularité que l'on lisse en regardant plus de $20$% du support alors que la régularité évolue sur l'ensemble de l'intervalle.

L'obtention de la fenêtre de lissage a été réalisée en réalisant une validation croisée sur une grille de fenêtre étalées sur une échelle de puissance entre $h_(min) = 2 \/ hat(lambda)$ et $h_(max) = 1 \/ hat(lambda)^(1\/3)$.

$ & cal(H) = {h_k, med k in intervaleint(1, K)} \
  forall k in intervaleint(1, K), quad & h_k = h_(min) e^(-a dot k) \
  sans("avec") quad & a = frac(log(h_(max)) - log(h_(min)), K) \
  sans("de valeur max") quad & h_K = h_(max) = h_(min) e^(-a dot K) \
  sans("et") quad & K = 30 $

Cela est dû au fait que $h^*_(cal(R)_sans("quadr")) = grandop(lambda^(- frac(1, 1 + 2H_t)))$ avec $0 < H_t < 1$, comme vu dans la section #ref(<sec:regloc-prelissage>). De plus, on souhaite que dans notre fenêtre de lissage, en moyenne, se trouvent 2 points au minimum.
