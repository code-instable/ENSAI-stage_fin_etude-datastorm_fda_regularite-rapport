// ~ src/content/appendix/absolu_vs_rel.tex
#import "../../../lib/math.typ": *
#import "../../../lib/components.typ": question

=== Distance Euclidienne

Afin de quantifier la qualité de l'estimation conjointe du couple de $theta$, il est raisonnable de considérer la distance euclidienne usuelle pour des vecteurs de $RR(2)$

$ R^(["rel"])_(m c) (Theta, Delta) = distnorme(2, hat(Theta)(Delta), tilde(Theta)(Delta))^2 $

=== Distance Euclidienne Relative

On va cependant considérer le risque relatif à la norme de la quantité que l'on cible :

$ R^(["rel"])_(m c) (Theta, Delta) = (distnorme(2, hat(Theta)(Delta), tilde(Theta)(Delta))^2)/(norme(2, tilde(Theta)(Delta))^2) $

#question[Pourquoi considérer la distance euclidienne relative à la norme de la cible $tilde(Theta)$ plutôt que la distance euclidienne classique qui est plus simple ?]

Le risque sert à déterminer la qualité de l'estimation du couple $tilde(Theta)$ par $hat(Theta)$ à un $Delta$ donné. Il faut cependant garder à l'esprit que $Theta$ est en réalité une fonction de $Delta$ car la valeur de $t_1, t_2, t_3$ dépendent de $Delta$. Ainsi _la norme de $tilde(Theta)$ va varier lorsque l'on fait varier $Delta$_#footnote[il est possible d'obtenir plus de détails en annexe #ref(<annexe:tous_theta_conviennent_borne_norme_theta>)]. Les risques obtenus via la norme euclidienne sont des risques qui mesurent une différence absolue, mais alors avoir _un risque plus petit qu'un autre n'a pas le même sens pour différents $Delta$ en termes de qualité d'approximation_. C'est pourquoi nous considérons le risque relatif dans la détermination du critère du choix du $Delta$.

On pourra cependant observer la différence entre le risque euclidien et le risque euclidien relatif à la norme de la cible en $Delta$ sur les figures #ref(<fig:sparse_osef>) et #ref(<fig:sparse_osef_rel>).
