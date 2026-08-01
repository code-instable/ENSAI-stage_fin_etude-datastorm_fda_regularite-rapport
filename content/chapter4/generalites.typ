// ~ src/content/chapter_4/__main__.tex (§ Généralités), and
// src/content/chapter_2/01-fda_essentiel/01-fda_essentiel-01-estim_adapt_informel.tex
// (the file is \input from *both* chapter_2 — commented out there, an
// obsolete leftover from restructuring — and chapter_4, its live location).
#import "../../lib/math.typ": *
#import "../../lib/components.typ": info, fbox
#import "../../lib/theorems.typ": thm-star

=== Estimation adaptative informelle

Les motivations de l'obtention de la régularité étaient en partie de pouvoir mieux estimer les quantités qui nous intéressent dont la fonction moyenne du processus, ainsi que son opérateur de covariance. Ce qui est à la fois important pour l'analyse (via l'interprétation de la base ACP déterminée par la covariance) et pour la prédiction. On peut alors se demander si il existe des estimateurs de la moyenne et de la covariance prenant en compte la régularité locale. C'est ce qu'affirme les théorèmes suivants :

#thm-star(name: [Estimateurs de la moyenne et de la covariance — informel #cite(<golovkine2021adaptive>)], key: "thm-star:estimation_adaptative")[
  #fbox[
    Il est possible en lissant les observations par méthode à noyaux avec une largeur de bande _spécifique à l'objet que l'on souhaite estimer_, de dériver des estimateurs de la moyenne et de la covariance qui convergent.
    La largeur de bande optimale _pour l'objet que l'on souhaite estimer_ est celle qui minimise un risque qui effectue un compromis biais-variance, qui dépend de la régularité locale du processus, en pénalisant les largeurs de bande menant à des "trous" dans les fonctions lissées.
    On parle d'_«#h(0.1em)estimation adaptative#h(0.1em)»_.
  ]
]

Cependant, bien qu'une largeur de bande optimale existe, elle est inconnue. Il est donc important de savoir si le praticien peut l'estimer, et avec quelle précision (c'est à dire à quel point l'estimateur sera biaisé ou non). C'est ce que nous affirme le théorème suivant :

#thm-star(name: [expression de la largeur de bande optimale — informel #cite(<golovkine2021adaptive>)], key: "thm-star:h_opt_estim")[
  #fbox[
    Sous certaines hypothèses de régularité du processus, et d'indépendance des temps observés, la largeur de bande optimale peut être approchée (avec forte probabilité de bonne approximation) par une expression ne dépendant que du nombre de courbes observées, du nombre moyen de temps observés par courbe, et de la régularité locale du processus. Ce biais de l'estimateur de la fonction moyenne est alors contrôlé en fonction de ces mêmes quantités.

    Sous des hypothèses un peu plus fortes sur la relation entre le nombre moyen d'observations par courbe et le nombre de courbes, on dispose de résultats similaires pour l'estimateur de la covariance.
  ]
]

Enfin, on peut se demander ce qu'il en est des estimateurs dans le cadre où l'on dispose de la dépendance dans les données (Ce qui est le cas pour les données de facteur de charge photovoltaïque notamment à travers la dépendance temporelle). Ce cas est traîté par le théorème suivant dérivé par MPV :

#thm-star(name: [Estimation adaptative de séries temporelles fonctionnelles — informel #cite(<maissoro-SmoothnessFTSweakDep>)], key: "thm-star:far_adaptative_estimation")[
  On peut estimer la régularité d'une série temporelle de données fonctionnelles à condition que la mémoire temporelle de la série soit courte. (La décroissance de la dépendance temporelle doit être au moins aussi rapide qu'une décroissance géométrique)
]

=== Les estimateurs

#info[Plus de précisions théoriques sur les estimateurs utilisés sont disponibles dans l'annexe #ref(<annexe:estim_adapt>).]

On utilisera les estimateurs considérés par MPV #cite(<maissoro-SmoothnessFTSweakDep>) pour la fonction moyenne :

On notera l'indicatrice de l'évènement «#h(0.1em)il y a suffisamment de points autour de $t$ pour le lissage à noyaux de la courbe $i$#h(0.1em)» : $pi_i (t med | med h)$#footnote[On ne demande la présence que d'un unique point, un autre seuil plus strict peut être fixé. Il a été aperçu empiriquement que l'amélioration de l'estimation n'est pas significative, un point suffit pour éviter la dégénérescence.].

Le nombre d'observations exploitables dans la bande $J_Delta$ est donc : $P_N^* = P_N (t med | med h_mu^* (Delta^*)) = sum_(i=1)^N pi_i (t med | med h_mu^* (Delta^*))$, et de manière équivalente on obtient le nombre d'observations exploitables pour l'estimation conjointe sur les courbes $i$ et $i + ell$ en $t$: $P_(i,ell)^*$.

$ hat(mu^*_sans("adapt")) (t) & = 1/P_N^* sum_(i=1)^N [pi_i dot hat(X)_i^([N W])] (med t med | med h_mu^* (Delta^*) med) \
  hat(gamma^*_sans("adapt")) (s, t, ell) & = 1/P^*_(i, ell) sum_(i=1)^(N-ell) [
    [pi_i dot hat(X)_i^([N W])] (med s med | med h_mu^* (Delta^*) med) [pi_(i+ell) dot hat(X)_(i+ell)^([N W])] (med t med | med h_mu^* (Delta^*) med)
  ] $

On établit désormais si la procédure de détermination du $Delta$ établie en section [#ref(<sec:determination-delta>)] permet bel et bien d'obtenir une bonne estimation des paramètres de régularité sur de nouvelles données générées.
