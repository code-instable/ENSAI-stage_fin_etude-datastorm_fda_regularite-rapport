// ~ src/content/appendix/theorie/brownien.tex
#import "../../../lib/math.typ": *
#import "../../../lib/components.typ": citer

=== Mouvement Brownien

Le concept du Mouvement Brownien, initialement découvert par Robert Brown en 1827, revêt une signification profonde dans le contexte des phénomènes aléatoires et a trouvé des applications éminentes dans les domaines de la physique, des mathématiques et au-delà. Il constitue un modèle fondamental pour décrire le comportement erratique et imprévisible des particules immergées dans un fluide, où chaque particule suit une trajectoire chaotique.

=== Mouvement Brownien Fractionnaire

Le Mouvement Brownien Fractionnaire, une extension du modèle classique et offre une perspective plus riche pour modéliser des phénomènes complexes. Son étude systématique s'est trouvée être fructueuse notamment dans des milieux tels que la finance. Il permet notamment d'étudier un phénomène non différentiable, Höldérien de paramètres $cal(H)_I (H, L)$

==== Construction du Mouvement Brownien Fractionnaire

Le lecteur pourra, si il le souhaite, trouver une définition du mouvement brownien fractionnaire ainsi que différentes méthodes de simulations de ce derniers dans la thèse doctorale de Ton Dieker (2004) #cite(<dieker2004simulation>).

#citer[
  Un mouvement Brownien fractionnaire normalisé $B_H = { B_H (t) : t in Rplus, H in ]0,1[ thin }$ est caractérisé de façon unique par :

  $ sans("les incréments de ") B_H (t) sans(" sont stationnaires") \
    B_H (0) = 0 \
    forall t in Rplus quad esperance(B_H (t)) = 0 \
    forall t in Rplus quad bb(E) abs(B_H (t))^2 = t^(2H) = sigma_H^2 (t) \
    forall t > 0 quad B_H (t) tilde cal(N)(0, sigma_H^2 (t)) \
    C_(B_H) (u,v) = esperance(B_H (u) B_H (v)) = 1/2 [u^(2H) + v^(2H) + abs(u-v)^(2H)] $

  #align(right)[source : Diecker, 2004 #cite(<dieker2004simulation>)]
]

Cela nous donne déjà une bonne idée de l'idée derrière la génération d'un processus Brownien multi-fractionnaire utilisé pour les simulations lors de ce stage.

=== Mouvement Brownien multi-fractionnaire

Le mouvement brownien multi-fractionnaire, lui, est de régularité variable sur le support. Il est donc idéal pour expérimenter sur l'estimation de la régularité locale. L'expression explicite de leur covariance a été dérivée notamment par Stoev et Taqqu en 2006 #cite(<mfbm-howrich>). Les processus browniens multi-fractionnaires sont aussi intéressants pour leur «#h(0.1em)richesse#h(0.1em)» : On peut pour chaque fonction $H : t |-> H_t$ observer «#h(0.1em)une diversité infinie de processus browniens multi-fractionnaires de manière générale#h(0.1em)».#cite(<mfbm-howrich>)
