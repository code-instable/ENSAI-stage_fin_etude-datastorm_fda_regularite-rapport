// ~ src/content/appendix/risque/couple_risk.tex
#import "../../../lib/math.typ": *
#import "../../../lib/components.typ": info, question

#info[
  on rappelle les notations suivantes :
  - vrai : $theta = bb(E)[thin f(X) thin]$
  - intangible/inobservable : $tilde(theta) = 1/N sum_i f(X_i)$
  - observable : $hat(theta) = 1/N sum_i f(hat(X)_i)$
]

L'estimation des paramètres de régularité locale en $t_2$, $H_(t_2)$ et $L_(t_2)$, utilise les incréments quadratiques $theta$ entre les différents points $t_1, t_2, t_3$ situés dans un voisinage de diamètre $Delta$ autour de $t_2$.

#question[
  Quelle quantité est-il judicieux d'évaluer pour estimer au mieux la régularité locale en $t_2$ ? Doit-t-on regarder la qualité de l'approximation de $theta$ (qui est une espérance) car il est utilisé pour tous les estimateurs ? Ou doit-on regarder la qualité de l'approximation de $H_(t_2)$ et $L_(t_2)$ car ce sont les quantités qui nous intéressent ? Ou bien les deux ?
]

Le choix du bon critère d'évaluation est d'une grande importance. Il faut se rappeler l'objectif que l'on cherche à atteindre : déterminer une procédure (simple si possible) de détermination de l'hyper-paramètre $Delta$ utilisé pour l'estimation de la régularité locale en fonction de quantités facilement estimables, ou directement observables par le praticien. En observant que $L$ est estimée par une expression impliquant $theta$ et $Delta^(2H)$, une estimation précise de $H$ paraît plus cruciale pour la bonne estimation des deux quantités. Bien qu'il existe certainement un compromis entre la bonne estimation de $H$ et de $L$ qui fournit une meilleure estimation adaptative des quantités qui nous intéressent, il est certainement plus probable de dériver une procédure de sélection de $Delta$ simple à implémenter pour le praticien en se basant sur la qualité de l'estimation d'une unique quantité.

#question[
  Doit-t-on se concentrer sur l'estimation de $H$ ou de $theta$ ?
]

Les incréments sont des quantités importantes dans l'estimation de la régularité, utilisées à la fois pour l'estimation de $H$ et de $L$, l'approche que l'on considère se base sur cette remarque. Nous allons donc chercher à déterminer un $Delta$ adapté à l'estimation des incréments quadratiques. Toutefois, il y a plusieurs possibilités de $u,v in J_Delta (t_2)$ que l'on peut considérer pour l'estimation de $H$ et $L$. C'est pourquoi nous décidons de considérer les _couples_ d'incréments utilisés pour l'estimation de $H$. Ainsi en posant :

#grid(
  columns: (1fr, 1fr),
  align(center)[$ thetaA = vec(theta(t_1, t_3), theta(t_1, t_2)) $],
  align(center)[$ thetaB = vec(theta(t_1, t_3), theta(t_2, t_3)) $],
)

L'estimateur du paramètre de régularité $H_t$ peut se ré-écrire comme :

$ hat(H)_t : Theta = vec(Theta_1, Theta_2) |-> (log hat(Theta)_1 - log hat(Theta)_2)/(2 log 2) $

Le problème c'est qu'on ne dispose pas de la véritable valeur de $theta(u,v)$, on pourrait exploiter le fait que l'on dipose d'un mouvement brownien multi-fractionnaire qui a été étudié de façon extensive dans la littérature, mais on décide de ne pas l'utiliser pour adopter une approche plus proche d'un cadre général.
Le meilleur estimateur que l'on puisse espérer atteindre est l'estimateur de l'espérance par la moyenne empirique des courbes non bruitées :

$ tilde(H)_t (thetaA) quad sans("ou") quad tilde(H)_t (thetaB) $

avec $tilde(H)_t : Theta |-> (log tilde(Theta)_1 - log tilde(Theta)_2)/(2 log 2)$

On va donc s'intéresser désormais à l'erreur d'estimation conjointe des deux $theta(u,v)$ utilisés dans l'estimation de $H_t$ par rapport à cet estimateur en quelque sorte «#h(0.1em)idéal#h(0.1em)» de $theta$ comme critère de sélection du diamètre $Delta$.

#figure(
  image("/src/Images/sketches/theta_biais.png", width: 70%),
  caption: [Schéma représentant les différentes approximations du couple d'incréments],
  kind: image, supplement: [Figure],
) <fig:sketch_theta_biais>
