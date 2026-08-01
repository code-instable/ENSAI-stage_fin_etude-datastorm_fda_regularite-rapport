// ~ src/content/chapter_3/choix-couple-increment.tex
#import "../../lib/math.typ": *
#import "../../lib/components.typ": info, question
#import "../../lib/theme.typ": numeq

La définition de l'estimateur de régularité locale nous permet de choisir parmi deux choix de couples d'incréments à utiliser comme mentionné en section #ref(<sec:deux_methodes_estim>) dans la définition #ref(<def:estim_reg>) (équations #ref(<eq:H_13_12>) et #ref(<eq:H_13_23>)). On nommera désormais les deux couples d'incrément possibles dans la définition de l'estimateur du paramètre de régularité $H$ :

#grid(
  columns: (1fr, 1fr),
  align(horizon)[
    #math.equation(numbering: numeq, block: true, $ thetaA = vec(med, theta(t_1, t_3), med, theta(t_1, t_2), med) = vec(med, theta_13, med, theta_12, med) $) <eq:thetaA_def>
  ],
  align(horizon)[
    #math.equation(numbering: numeq, block: true, $ thetaB = vec(med, theta(t_1, t_3), med, theta(t_2, t_3), med) = vec(med, theta_13, med, theta_23, med) $) <eq:thetaB_def>
  ],
)

#info[
  #align(center)[
    Ainsi l'estimateur «#h(0.1em)plug-in#h(0.1em)» des courbes pleinement observées (intangible) est noté $tilde(Theta)$, et l'estimateur «#h(0.1em)plug-in#h(0.1em)» empirique $hat(Theta)$.
  ]
]

#question[
  #align(center)[Existe-t-il un couple d'incréments plus facile à estimer qu'un autre ?]
]

On n'observe pas sur les simulations menées dans le cadre de ce stage de différence significative entre le risque d'estimation du couple $thetaA$ et du couple $thetaB$ pour le risque relatif. Sur les points moins réguliers, où l'ordre de grandeur du risque est plus élevé, on constate que le couple $thetaB$ a de meilleures performances, même si la différence reste relativement mineure. Le choix de l'un ou de l'autre ne devrait pas en pratique affecter grandement l'estimation du couple. On recommandera toutefois pour la raison évoquée précédemment de privilégier si possible l'utilisation du couple qui utilise l'information plus régulière si on dispose d'une information a priori sur celle-ci.

== Détermination du Δ optimal à choisir pour l'estimation de la régularité <sec:determination-delta>

L'étude des courbes de risques obtenues :

#math.equation(numbering: numeq, block: true, $ hat(cal(R))^(["rel"]) (med Theta med , med Delta med)
  = frac(1, m c) sum_(p=1)^(m c) frac(distnorme(2, hat(Theta)[med p med], tilde(Theta)[med p med])^2, norme(2, tilde(Theta)[med p med])^2) $) <eq:risque_rel_delta>

où $[med p med]$ signifie que la quantité a été calculée à partir de la $p^sans("eme")$ réplication de Monte-Carlo de la simulation.

indique la sélection du $Delta$ par la procédure suivante#footnote[Des détails sur la détermination de la procédure de sélection du $Delta$ en annexe #ref(<annexe:choix_risque_couple>)] :

- *Détermination de la fenêtre de pré-lissage :*
  - calculer $hat(lambda)$, le nombre moyen de points par courbe et effectuer une validation croisée de la fenêtre de lissage sur une grille d'échelle comprise entre $display(2/hat(lambda))$ et $display(1/hat(lambda)^(1\/3))$
  - Il est important de prendre en compte les «#h(0.1em)trous#h(0.1em)» lors du lissage à noyau des courbes. Il convient donc de ne pas sélectionner les fenêtres de lissage où le lissage à noyau a échoué sur une partie du support.#footnote[On pourra se référer à l'annexe #ref(<annexe:lissage_fail>) pour plus de détails.]
  - Pour les données *«#h(0.1em)sparses#h(0.1em)»* en nombre moyen d'observations par courbe ($hat(lambda) lt.eq 100 sans(" à ") 150$) : Bien lisser les courbes individuellement en déterminant la fenêtre de lissage par validation croisée. Pour les données *«#h(0.1em)denses#h(0.1em)»* en nombre moyen d'observations par courbes, économiser du temps de calcul est possible en effectuant un lissage global avec une fenêtre obtenue en gardant la médiane des fenêtres optimales pour les premières courbes (_cf_ tables #ref(<tab:couple_1312_indiv_vs_glob>) et #ref(<tab:stat_R_eucl_min_max_q>)).

  - *Choix du couple :*
    - *on dispose d'une information a priori sur une idée des zones plus ou moins régulières de données :* Il est conseillé d'estimer le couple dont la deuxième composante (c'est à dire soit $theta_12$ soit $theta_23$) est celle qui pointe vers l'information la plus régulière. Même si les risques entre les couples $thetaA$ et $thetaB$ sont proches, le couple utilisant $theta_23$ est meilleur sur les parties moins régulières. Dans le cadre de notre simulation $theta_23$ correspondait à l'information plus régulière (car $t |-> H_t$ était croissante).
    - *On ne dispose d'aucune information à priori sur la régularité :* Les deux couples ne disposent pas d'un risque qui diffère grandement (_cf_ graphiques #ref(<fig:sparse_osef_rel>)). Dans le doute sélectionner $thetaB$

  - *Choix du $Delta$ : * En se référant aux graphiques en annexe #ref(<fig:sparse_osef_rel>), on recommande l'utilisation d'un $Delta$ relativement grand vis-à-vis du support. Les graphes des risques indiquent que les $Delta$ de la taille de 10 à 20% du support étaient à risques relatifs équivalents, et ce pour les différents niveaux de régularité (0.5 à 0.7). C'est pourquoi dans l'optique d'une estimation de la régularité «#h(0.1em)locale#h(0.1em)» on recommande plutôt de se situer aux environs de 10-15% du support pour bénéficier du plateau autour, tout en restant «#h(0.1em)local#h(0.1em)».#footnote[sera détaillé en discussion]
