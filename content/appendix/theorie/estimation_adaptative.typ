// ~ src/content/appendix/theorie/estimation_adaptative/{main,intro,estimation_adaptative__moyenne}.tex
// (estimation_adaptative__covariance.tex is excluded: its own \input in main.tex
// is commented out)
#import "../../../lib/math.typ": *
#import "../../../lib/components.typ": info
#import "../../../lib/plot.typ": error-decomposition-diagram
#import "../../../lib/theme.typ": flat

Dans la section précédente, nous avons déterminé comment obtenir des estimateurs de la régularité locale des trajectoires. Cette régularité locale nous permet désormais de lisser les courbes observées de manière à ne pas détruire l'information irrégulière. L'obtention d'un tel lissage était motivé notamment par l'obtention de quantités capitales pour l'analyse de nos données, l'interprétation et la prise de décision : la moyenne, la covariance, et l'auto-corrélation des séries temporelles fonctionnelles observées.

Un meilleur lissage nous donne ainsi une meilleure estimation de ces quantités. Toutefois, il est possible d'aller plus loin dans l'adaptation de notre lissage. En effet, il faut dans un premier temps constater que les différentes quantités que l'on souhaite estimer représentent des concepts différents, préférant chacun un lissage différent.

=== Estimation adaptative de la fonction moyenne

L'idée du lissage adaptatif est que chaque quantité évaluée en un point $t in cal(T)$ tire parti différemment des information du voisinage de $t$. Il semble intuitif que le processus moyen ($mu = esperance(X)$) considère des informations d'un voisinage assez large du processus et que celui-ci soit «#h(0.1em)assez lisse#h(0.1em)». Pour déterminer une fenêtre adaptée à l'estimation de la moyenne, on définit une grille de fenêtres à évaluer $frak(H) = (h_i)_(1:r)$ que l'on choisit en minimisant un risque spécifiquement adapté :

$ hat(h_mu^*) = argmin_(h in frak(H)) R_mu (t, h) $

Déterminons maintenant ce risque.

==== Méthode Golovkine et al. : indépendance

Dans le cadre de données indépendantes, on peut invoquer la Loi des Grands Nombres pour approximer l'espérance par la moyenne empirique.
On effectue une suite d'approximations de la façon suivante :

#figure(
  error-decomposition-diagram(
    $tilde(mu_(cal(W)))$, $tilde(mu)$, $hat(mu)$, $mu$,
    [absence points $cal(W)$], [LGN], [biais $bb(B)$],
  ),
  caption: [Schéma du découpage du contrôle des erreurs],
  kind: image, supplement: [Figure],
)

On détermine alors fenêtre de lissage en minimisant le risque suivant #cite(<golovkine2021adaptive>) :

$ R_mu^([sans("Golovk.")]) (t,h) = underbracket(q_1^2 h^(2H_t), sans("contrôle du biais")) + underbracket((q_2^2)/(cal(N)_mu (t,h)), sans("contrôle de la variance")) + underbracket(q_3^2 [1/(sum_k w_k) - 1/n], sans("pénalise absence de points")) $

#info[
  Il est tout à fait possible de regarder directement l'erreur d'approximation entre $tilde(mu_(cal(W)))$ et $mu$. Toutefois, le choix de Golovkine est avant tout un choix pédagogique, pour signaler et renforcer l'idée qu'il faut faire attention à l'erreur d'approximation entre l'inobservable et le véritable processus ( $bb(E) thin X$ vs $1/N sum X_i eq.not 1/N sum hat(X)_i$)
]

Afin de prendre en compte la dépendance, que l'on doit contrôler aussi, on raisonne plutôt de la façon suivante.

==== Méthode MPV : dépendance

Lorsque l'on traite le cas de la dépendance, il est tout de suite plus délicat d'obtenir la convergence d'estimateurs de moments d'une loi. MPV utilise ce découpage du risque pour déterminer une fenêtre de lissage adaptée à l'estimation de la fonction moyenne :

#figure(
  error-decomposition-diagram(
    $tilde(mu_(cal(W)))$, $tilde(mu)$, $hat(mu)$, $mu$,
    [absence points $cal(W)$], [LGN], [biais $bb(B)$],
    right-color: flat.light-gray, down-color: flat.light-gray,
    diagonal-label: [MPV : absence points $P_N$ + dépendance $bb(D)$],
    diagonal-color: flat.green,
  ),
  caption: [Schéma du découpage du contrôle des erreurs],
  kind: image, supplement: [Figure],
)

On détermine cette fois-ci la fenêtre de lissage en minimisant le risque suivant #cite(<maissoro-SmoothnessFTSweakDep>) :

$ R_mu (t,h) = underbracket(L_t^2 h^(2H_t) bb(B)(t,h,2H_t), sans("contrôle du biais")) + underbracket(sigma^2 bb(V)_mu (t,h), sans("contrôle de la variance")) + underbracket((bb(D)_mu (t))/(P_N (t,h)), sans("contrôle de la dépendance")) $

=== Quelques remarques sur les applications

Bien que la théorie suppose des données dépendantes, il est tout à fait possible d'appliquer les estimateurs dérivés pour des données dépendantes sur des données indépendantes. Il ne devrait pas y avoir en pratique de différences significatives de performances lors de l'utilisation des estimateurs dérivés par MPV sur des données indépendantes. Lors de l'estimation de la fonction moyenne lors du stage, l'estimateur pour les données dépendantes a été utilisé sur l'ensemble des données traitées.
