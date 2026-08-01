// ~ src/content/appendix/risque/h_glob_indiv/h_glob_vs_indiv_graphs.tex
#import "../../../lib/math.typ": *
#import "../../../lib/components.typ": warn

#figure(
  {
    grid(
      columns: (0.43fr, 0.43fr),
      column-gutter: 1fr,
      image("/src/Images/indiv_vs_glob/qq160.png", width: 100%),
      image("/src/Images/indiv_vs_glob/lbd60mc164c1.png", width: 100%),
    )
    v(0.6em)
    grid(
      columns: (0.43fr, 0.43fr),
      column-gutter: 1fr,
      image("/src/Images/indiv_vs_glob/qq210.png", width: 100%),
      image("/src/Images/indiv_vs_glob/lbd210_mc91_c64.png", width: 100%),
    )
  },
  caption: [Distribution des risques et aperçu d'une courbe pour un échantillon de Monte-Carlo extrême sur le risque euclidien.],
  kind: image, supplement: [Figure],
) <fig:dist_R_eucl_curves>

#figure(
  image("/src/Images/indiv_vs_glob/Tdensity_lbd60_mc164.png", width: 70%),
  caption: [Densité de points observés sur $[0.65, 0.95]$ pour $lambda = 60$ sur un échantillon de Monte-Carlo extrême, en un $Delta$ problématique.],
  kind: image, supplement: [Figure],
) <fig:den_ex>

#figure(
  image("/src/Images/indiv_vs_glob/worst_210_67_mc6.png", width: 70%),
  caption: [Densité des points observés correspondant à la courbe présentée sur la figure #ref(<fig:dist_R_eucl_curves>).],
  kind: image, supplement: [Figure],
) <fig:den_counterex>

#v(1.5em)

#warn[
  #align(center)[
    Dans l'ensemble des graphes suivants se trouve une erreur de labélisation des graphes : La métrique $cal(R)$ considérée est bel et bien la norme euclidienne *au carré* $cal(R)(Theta, Delta) = bb(E) distnorme(2, hat(Theta), tilde(Theta))^2$. De même que la norme relative considérée est la norme relative *au carré* $display(cal(R)(Theta, Delta) = bb(E) (distnorme(2, hat(Theta), tilde(Theta))^2)/(norme(2, tilde(Theta))))$
  ]
]

#figure(
  {
    strong[avec extrêmes : global]
    v(0.5em)
    image("/src/Images/indiv_glob_img/compare/210_regular/all_glob.jpg", width: 90%)
    v(0.8em)
    strong[avec extrêmes : individuel]
    v(0.5em)
    image("/src/Images/indiv_glob_img/compare/210_regular/all.jpg", width: 90%)
    v(0.8em)
    [#strong[sans extrêmes : global] (- top 2%)]
    v(0.5em)
    image("/src/Images/indiv_glob_img/compare/210_regular/no_xtrm_glob.jpg", width: 90%)
    v(0.8em)
    [#strong[sans extrêmes : individuel] (- top 2%)]
    v(0.5em)
    image("/src/Images/indiv_glob_img/compare/210_regular/no_xtrm.jpg", width: 90%)
  },
  caption: [Risque Euclidien pour $N=200$, $lambda=210$ en un point régulier selon la méthode utilisée pour la fenêtre de lissage],
  kind: image, supplement: [Figure],
) <fig:compare_xtrm_2>

#figure(
  {
    strong[ H = 0.51 ]
    v(0.5em)
    [Sparse :]
    image("/src/Images/risque/N200_t0.3_lbd60.jpg", width: 80%)
    v(0.5em)
    [Dense :]
    image("/src/Images/risque/N200_t0.3_lbd210.jpg", width: 80%)
  },
  caption: none, outlined: false,
  kind: image, supplement: [Figure],
)

#figure(
  {
    strong[ H = 0.6 ]
    v(0.5em)
    [Sparse :]
    image("/src/Images/risque/N200_t0.5_lbd60.jpg", width: 80%)
    v(0.5em)
    [Dense :]
    image("/src/Images/risque/N200_t0.5_lbd210.jpg", width: 80%)
  },
  caption: none, outlined: false,
  kind: image, supplement: [Figure],
)

#figure(
  {
    strong[ H = 0.73 ]
    v(0.5em)
    [Sparse :]
    image("/src/Images/risque/N200_t0.8_lbd60.jpg", width: 80%)
    v(0.5em)
    [Dense :]
    image("/src/Images/risque/N200_t0.8_lbd210.jpg", width: 80%)
  },
  caption: [Graphe des risques *euclidiens* dans les cas «#h(0.1em)sparse#h(0.1em)» et «#h(0.1em)raisonnablement dense#h(0.1em)», ayant enlevé les observations extrêmes ($lt.eq$ 20% des échantillons de Monte-Carlo)],
  kind: image, supplement: [Figure],
) <fig:sparse_osef>

#figure(
  {
    strong[ H = 0.51 ]
    v(0.5em)
    [Sparse :]
    image("/src/Images/eucl_rel/N200_λ060_t0.3_kernel.jpg", width: 80%)
    v(0.5em)
    [Dense :]
    image("/src/Images/eucl_rel/N200_λ210_t0.3_kernel.jpg", width: 80%)
  },
  caption: none, outlined: false,
  kind: image, supplement: [Figure],
)

#figure(
  {
    strong[ H = 0.6 ]
    v(0.5em)
    [Sparse :]
    image("/src/Images/eucl_rel/N200_λ060_t0.5_kernel.jpg", width: 80%)
    v(0.5em)
    [Dense :]
    image("/src/Images/eucl_rel/N200_λ210_t0.5_kernel.jpg", width: 80%)
  },
  caption: none, outlined: false,
  kind: image, supplement: [Figure],
)

#figure(
  {
    strong[ H = 0.73 ]
    v(0.5em)
    [Sparse :]
    image("/src/Images/eucl_rel/N200_λ060_t0.8_kernel.jpg", width: 80%)
    v(0.5em)
    [Dense :]
    image("/src/Images/eucl_rel/N200_λ210_t0.8_kernel.jpg", width: 80%)
  },
  caption: [Graphe des *risques euclidiens relatifs* à $tilde(Theta)(Delta)$ dans les cas «#h(0.1em)sparse#h(0.1em)» et «#h(0.1em)raisonnablement dense#h(0.1em)», ayant enlevé les observations extrêmes ($lt.eq$ 20% des échantillons de Monte-Carlo)],
  kind: image, supplement: [Figure],
) <fig:sparse_osef_rel>
