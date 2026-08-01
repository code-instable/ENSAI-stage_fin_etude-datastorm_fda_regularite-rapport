// ~ src/content/chapter_2/04-critere/critere.tex
#import "../../lib/math.typ": *
#import "../../lib/components.typ": question
#import "../../lib/theme.typ": numeq

L'estimation des paramètres de régularité locale en $t_2$ ( $H_(t_2)$ et $L_(t_2)$ ) utilise les incréments quadratiques $theta$ entre les différents points $t_1, t_2, t_3$ situés dans un voisinage de diamètre $Delta$ autour de $t_2$.
En observant que $L$ est estimée par une expression impliquant $theta$ et $Delta^(2H)$, d'une part, et le fait que $H$ est utilisé dans l'estimation adaptative d'une multitude de quantités qui intéressent le statisticien (covariance, ...) : une estimation précise de $H$ paraît plus cruciale pour la bonne estimation conjointe des deux quantités.

#question[
  #align(center)[Doit-t-on se concentrer sur l'estimation de $H$ ou de $theta$ ?]
]

Les incréments quadratiques $theta$ sont utilisées à la fois pour l'estimation de $H$ et de $L$. Nous allons donc chercher à déterminer un $Delta$ adapté à l'estimation des incréments quadratiques. En effet, un mauvaise estimation des incréments induirait une mauvaise estimation de $H$. Puisque l'on a déterminé qu'une bonne estimation de $H$ était cruciale, et que cette quantité utilise deux valeurs d'incréments distinctes, nous allons nous focaliser sur l'estimation d'un couple de $theta$ que nous noterons $Theta$.

Le but étant d'obtenir un $Delta$ utile en pratique, nous réalisons une simulation de Monte-Carlo avec $m c = 200$ réplications indépendantes de la procédure d'estimation des paramètres de régularité locale. Et nous cherchons alors à déterminer quel $Delta$ est meilleur en pratique sur les données simulées.

La métrique que nous allons sélectionner est _la distance euclidienne entre une estimation d'un tel couple $Theta$, que l'on nomme $hat(Theta)$ et l'estimateur de l'espérance via la moyenne empirique des courbes non bruitées, observées pleinement, *relativement* à la cible de l'estimation $tilde(Theta)$_. En effet, il s'agit du meilleur estimateur de l'espérance que l'on pourrait espérer atteindre (du biais est introduit lors du lissage non paramétrique des courbes bruitées). On considère donc le risque suivant :

#math.equation(numbering: numeq, block: true, $ bb(E)_p frac(distnorme(2, hat(Theta)[p], tilde(Theta)[p])^2, norme(2, tilde(Theta)[p])^2)
  = cal(R)^(["rel"]) (med Theta med , med Delta med)
  approx hat(cal(R))^(["rel"]) (med Theta med , med Delta med)
  = 1/(m c) sum_(p=1)^(m c) frac(distnorme(2, hat(Theta)[p], tilde(Theta)[p])^2, norme(2, tilde(Theta)[p])^2) $) <eq:risque_rel_def>

#figure(
  grid(
    columns: (0.65fr, 0.3fr),
    column-gutter: 1em,
    align(horizon, image("/src/Images/sketches/theta_biais.png", width: 80%)),
    align(horizon)[
      Dans la formulation du risque,
      $[p]$ désigne la $p^sans("eme")$ réplication de Monte-Carlo de la quantité considérée.
    ],
  ),
  caption: [Schéma représentant les différentes approximations du couple d'incréments],
  kind: image, supplement: [Figure],
) <fig:sketch_theta_biais_corpus>
