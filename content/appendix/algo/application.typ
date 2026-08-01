// ~ src/content/appendix/chap_algo.tex (§ \chapter{Application})
#figure(
  {
    grid(
      columns: (0.32fr, 0.32fr, 0.32fr),
      column-gutter: 1fr,
      row-gutter: 0.5em,
      align(center)[6h], align(center)[6h30], align(center)[7h],
      image("/src/Images/pv_pre/6h.png", format: "jpg", width: 100%),
      image("/src/Images/pv_pre/06:30:00.jpg", width: 100%),
      image("/src/Images/pv_pre/07:00:00.jpg", width: 100%),
      image("/src/Images/pv_pre/20:30:00.jpg", width: 100%),
      image("/src/Images/pv_pre/21:00:00.jpg", width: 100%),
      image("/src/Images/pv_pre/21:30:00.jpg", width: 100%),
      align(center)[20h30], align(center)[21h], align(center)[21h30],
    )
    v(0.8em)
    [_On constate qu'avant 6h30 et après 20h30, la distribution de la production électrique est telle que l'on peut la considérer nulle : des valeurs extrêmes de l'ordre de grandeur de $10^(-3)$ en facteur de charge et très concentrées autour d'une valeur presque nulle. Pendant les périodes de jour ( entre 6h30 et 20h30 ) on observe un étalement dans la distribution ainsi que des valeurs plus élevées de l'odre de grandeur de $10^(-2)$ à $10^(-1)$ pour le début de la journée._]
  },
  caption: [Distribution du facteur de charge l'ensemble des journées d'un parc photovoltaïque pendant la période estivale, observée à différentes heures],
  kind: image, supplement: [Figure],
) <fig:boxplot_pv_journee>
