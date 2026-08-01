// ~ src/content/chapter_2/03-simulation/*
#import "../../lib/math.typ": *
#import "../../lib/components.typ": question, citer, fbox, circled
#import "../../lib/theorems.typ": rem
#import "../../lib/theme.typ": numeq

=== Objectifs de la simulation <subsec:sim-objectif>

L'objectif de la simulation est de pouvoir analyser le comportement des estimateurs des paramètres de régularité lorsque l'on fait varier $Delta$, le diamètre du voisinage $J_Delta$ dans lequel on vient utiliser de l'information pour capter la régularité. Cela permettra ensuite d'analyser cette fois le comportement de $Delta^*$, le $Delta$ optimal pour l'estimation des paramètres de régularité.

Jusqu'alors, on s'est surtout préoccupé d'expliquer l'intérêt et la méthodologie associée à l'obtention de la régularité. Toutefois différentes questions se posent vis-à-vis de cette estimation, notamment en lien avec le choix du $Delta$ :

#question[
  #circled[1] : Le risque associé à l'estimation des paramètres de régularité, est il une fonction convexe (voire strictement convexe) de $Delta$ ? Sinon, l'est-elle au moins au voisinage du $Delta^*$ optimal pour l'estimation de la régularité ?

  #v(1em, weak: true)

  #circled[2] : Quel lien, si il en existe un, y-a-t-il entre $Delta^*$ et d'autres quantités susceptibles d'affecter la vitesse de convergence de l'estimateur : $N$, $lambda = esperance(M_n)$, $H_(t_2)$, ... ?

  #v(1em, weak: true)

  #circled[3] : Peut-on fournir une procédure simple de détermination d'un $Delta$ proche du $Delta^*$ optimal, pouvant être obtenu à partir des données pour être utilisé en pratique par les statisticiens ?
]

=== Mouvement Brownien Multi-Fractionaire (mfBm) <subsec:mfbm>

Afin de simuler un processus Höldérien non dérivable, on choisit de simuler un mouvement Brownien Multi-Fractionnaire. En effet il s'agit d'un processus qui, presque-sûrement, est continu mais différentiable nulle part. Le mouvement brownien multi-fractionnaire est d'autant plus intéressant dans le cadre de la simulation car on sait le générer en contrôlant localement sa régularité sur un voisinage $V$ de $t_0$.

$ forall u,v in V quad esperance(abs(xi_n (u) - xi_n (v))^2) bold(approx) L_(H_xi (t_0)) abs(u - v)^(2 H_xi (t_0)) $

Le lecteur pourra, si il le souhaite trouver plus de ressources, définitions et propriétés formelles sur le mouvement brownien fractionnaire et multi-fractionnaire en annexe #ref(<annexe:brownien>). Le point essentiel exploité par l'algorithme utilisé pour la simulation est le suivant : le mouvement brownien multi-fractionnaire est un processus gaussien dont on sait expliciter la covariance en fonction de la régularité des instants considérés :

$ C(t,s) = D(H_s, H_t) [s^(H_s + H_t) + t^(H_s + H_t) - abs(t-s)^(H_s + H_t)] $

avec :

$ D(x,y) = frac(sqrt(Gamma(2x+1) Gamma(2y+1) sin(pi x) sin(pi y)), 2 Gamma(x+y+1) sin(pi (x+y)/2)) $

il nous suffit donc de déterminer la matrice suivante :

$ Sigma = mat(delim: "[", dots.down, dots.v, rddots;
  , D(H(t_i), H(t_j)) dot (t_i^(H(t_i)+H(t_j)) + t_j^(H(t_i)+H(t_j)) - abs(t_i - t_j)^(H(t_i)+H(t_j))), ;
  rddots, dots.v, dots.down;
) $

avec :

$ t_i, t_j in bb(T) = { underbrace(mat(delim: #none, t_1 (Delta, t) med , med t_2 (t) med , med t_3 (Delta, t); t in arrow(t) quad Delta in arrow(Delta);), sans("estimateur de régularité")) quad , med underbrace(g_1 dots g_G, sans("grille pour l'") integral sans(" de la relation FAR")) , med underbrace(T_n [1] dots T_n [M_n], sans("points observés (aléatoire)")) } $

Pour simuler un mouvement brownien multi-fractionnaire en les points désirés, il convient donc de simuler une loi normale multivariée d'espérance nulle et de covariance $Sigma$.

#rem(name: [complexité de la simulation], key: "rem:inversion_matrice_covariance_mfbm_informel")[
  La méthode de génération du mouvement brownien multi-fractionnaire via une loi normale multi-variée implique l'inversion d'une matrice de covariance. Dans le cadre du stage les simulations sont implémentées en R, et la fonction qui génère une réalisation de variable aléatoire gaussienne multivariée est la fonction #raw("mvrnorm", lang: "r") du package R *MASS*. La méthode utilisée pour l'inversion de cette matrice par la fonction #raw("MASS::mvrnorm", lang: "r") utilisée pour la simulation est via la décomposition spectrale de celle-ci.

  #citer[
    The matrix decomposition is done via #raw("eigen", lang: "r"); although a Choleski decomposition might be faster, the eigendecomposition is stabler.

    #align(right)[– Documentation du package R MASS #cite(<R-MASS>)]
  ]
  L'inversion de la matrice de covariance via sa décomposition spectrale est un algorithme de complexité $grando((op("card") bb(T))^3)$. Ce qui implique qu'évaluer de plus en plus de point sur le même processus devient rapidement cher en calcul.
]

=== génération d'un $op("FAR")(1)$ <subsec:far>

Parmi les avantages de l'utilisation d'un mouvement brownien multi-fractionnaire à simuler pour analyser le comportement du $Delta$ se trouve le fait que l'on peut dériver facilement la régularité des courbes d'une relation $op("FAR")(1)$ basée sur ce processus. En effet, supposons que l'opérateur linéaire de cette relation $phi.alt$ est un opérateur intégral $X |-> integral beta(u,t) X(u) d u$ et que $beta in cal(H)_V (H_beta, L_beta)$ ainsi que $xi in cal(H)_V (H_xi, L_xi)$. Il suffit alors que $H_beta > H_xi$ pour que le $op("FAR")(1)$ hérite de la régularité du mouvement brownien multi-fractionnaire. Ainsi on dispose directement de la régularité de notre $op("FAR")(1)$ en chaque point du support, ce qui s'avère très utile pour analyser les résultats.

Afin de générer la $N^sans("eme")$ observation d'un $op("FAR")$ définie par la relation auto-regressive suivante :

#math.equation(numbering: numeq, block: true, $ X_N (t) = integral beta(u,t) X_(N-1) (u) d u + xi_N (t) $) <eq:rel_far_sim>

Ainsi, il nous suffit de générer $N$ mouvements browniens multi-fractionnaires indépendants aux points dont on a besoin l'évaluation du mouvement brownien :

$ (xi_1 med, med xi_2, med dots med, med xi_N) tilde op("mfBm")(H, L) $

que l'on utilise comme innovations dans la relation $op("FAR")(1)$ $[$eq. #ref(<eq:rel_far_sim>)$]$. La méthode de calul numérique de l'intégrale sélectionnée est la _méthode des rectangles au point médian_ car il s'agit de la méthode de calcul numérique d'intégrale de plus grand ordre avec $1$ unique point d'évaluation requis pour le calcul, ce qui est primordial vis à vis de la remarque formulée dans la section #ref(<rem:inversion_matrice_covariance_mfbm_informel>).

Afin d'atteindre la stationnarité, on effectue une période de «#h(0.1em)Burn-in#h(0.1em)» où l'on génère un nombre d'éléments (100) non retenus dans l'échantillon sauvegardé. En appelant $B$ le nombre d'étapes de burn-in, on génère donc $N+B$ mouvements browniens multi-fractionnaires $(xi_1 med, med dots med, med xi_B med, med dots med , med xi_(N+B))$ indépendants aux points désirés, on applique à chaque itération la relation $op("FAR")(1)$ et on ne retient que les $N$ dernières itérations.

L'algorithme utilisé pour la génération du $op("FAR")(1)$ basée sur un opérateur intégral comme défini par la relation #ref(<eq:rel_far_sim>) est disponible en annexe : Algorithme #ref(<alg:gen_far_grid>).
