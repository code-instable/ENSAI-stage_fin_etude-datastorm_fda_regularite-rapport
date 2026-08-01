// ~ src/content/appendix/theorie/ts/{main,alpha_mixing,inversion,Lpm_approx,pk_L_infini}.tex
// (ts/LGN.tex is excluded: its own \input in ts/main.tex is commented out and
// the file is itself empty)
#import "../../../lib/math.typ": *
#import "../../../lib/components.typ": blackboxed, blueboxed, orangeboxed, citer, idee, warn, question, colorize, mathbox
#import "../../../lib/theme.typ": flat
#import "../../../lib/theorems.typ": definition, leftbar

#blackboxed[✎ : Explication de la correction]
#leftbar[
  La dépendance dite de «#h(0.1em)alpha-mixing#h(0.1em)» n'est pas une dépendance «#h(0.1em)forte#h(0.1em)». C'est en fait le contraire : il s'agit d'une dépendance faible mais d'un autre type de dépendance. Il y a plusieurs façon de faire de la dépendance faible : le «#h(0.1em)$alpha$-mixing#h(0.1em)» et la «#h(0.1em)$bb(L)^p - a$ approximation#h(0.1em)». L'une n'est pas spécialement plus faible que l'autre mais chacune peut avoir son avantage dans certains contextes théoriques et bien choisir sa dépendance faible (qui restent tout de même des concepts non équivalents donc faut faire attention et bien revenir à la défnition de celle que l'on utilise) peut alors permettre de rendre la démonstration de convergence des estimateurs qui nous intéressent plus facile.

  La confusion vient du fait que l'on lit en anglais dans la littérature «#h(0.1em)strongly mixing#h(0.1em)» ou «#h(0.1em)strongly $alpha$-mixing#h(0.1em)». Il existe des cas où les données sont à la fois «#h(0.1em)strongly $alpha$-mixing#h(0.1em)» et «#h(0.1em)$bb(L)^p - a$ approximables#h(0.1em)».

  Le point de vue «#h(0.1em)strongly-mixing#h(0.1em)» est en résumé une autre perspective de la dépendance faible qui regarde le défaut de dépendance au niveau de la mesure de probabilité par la caractérisation (souvent aussi définition chez la grande majorité des auteurs) :

  $ A indep B <==> proba(A inter B) = proba(A) dot.op proba(B) $
]

Il existe plusieurs façons de définir une «#h(0.1em)dépendance faible#h(0.1em)», notamment la dépendance dite de «#h(0.1em)$alpha$-mixing#h(0.1em)» comme définie dans #cite(<estimation-dependent-strong-mixing>) :

#definition(name: [$alpha-$mixing])[
  une suite $X = suite(X,i)$ de variables aléatoire est dite $alpha$-mixing si pour tout $n in bb(N)$

  $ alpha(n) tend(n, infinity) 0 $

  avec : $alpha(n) = sup_k { abs(proba(A inter B) - proba(A) proba(B)) quad mid(|) quad A in sigma(fromto(X,1,k)), thin B in sigma(fromto(X, k+n, infinity)) }$

  en d'autres termes, la «#h(0.1em)dépendance#h(0.1em)» #colorize($(abs(thin proba(A inter B) - proba(A) proba(B) thin))$, color: flat.blue-devil) entre les variables aléatoires $X_k$ et $X_(k+n)$ tend vers 0 lorsque $n$ tend vers l'infini.
]

Dans ce point de vue on manipule directement les tribus engendrées par les différents stades de passé de la série temporelle et on regarde leur degré d'indépendance via la mesure de probabilité. Il ne s'agit pas de l'approche considérée par MPV, en se reposant non pas sur l'indépendance des tribus engendrées par le passé de la série temporelle mais en exploitant la qualité d'approximation de la série temporelle que l'on étudie par un autre processus, indépendant de la série temporelle étudiée à partir d'un certain rang. La définition de dépendance temporelle est alors dite «#h(0.1em)faible#h(0.1em)» *car il existe de la dépendance mais qui décroit rapidement*. Le point de vue #strike(text(fill: flat.rose)[faible]) *adopté par MPV* offre un comportement plus sympathique pour l'aspect _local_ dans l'estimation de la régularité : qui est le coeur de l'approche de MPV.

Hormann et Kokoszka #cite(label("10.1214/09-AOS768")) parlent des avantages de l'approche de l'approximation $bb(L)^p - a$ par rapport à l'approche du «#h(0.1em)strongly-mixing#h(0.1em)» dans leur article «#h(0.1em)Weakly dependent functional data#h(0.1em)» :

#citer[
  #blueboxed[✎ citation rajoutée]

  L'approche classique de la dépendance faible, dévelopée notamment par Rosenblatt et Ibragimov, utilise la propriété dite de «#h(0.1em)fort mélange#h(0.1em)» et de ses variants comme les mélanges $beta$, $phi$, $rho$ et $alpha$. L'idée générale est de mesurer al dépendance maximale entre deux évènements respectivement du «#h(0.1em)passé#h(0.1em)» $cal(F)_k^-$ et du «#h(0.1em)futur#h(0.1em)» $cal(F)_(k+m)^+$. L'estompage de la mémoire est décrit par cette dépendance maximale qui tenderait vers $0$ lorsque $m$ tend vers l'infini. par exemple le coefficient de mélange $alpha$ est donné par :

  $ alpha(m) = sup_(A in cal(F)_k^-, B in cal(F)_(k+m)^+) abs(bb(P)(A inter B) - bb(P)(A) bb(P)(B)) $

  et alors une séquence est dite $alpha$-mélangeante si $alpha(m) limits(-->)_(m arrow infinity) 0$.

  [...]

  Cette méthode donne des résultats très solides (pour un exposé complet de la théorie classique, voir Bradley ), mais il n'est pas possible de vérifier les conditions de mélange du type susmentionné.( voir Bradley ), mais la vérification des conditions de mélange du type ci-dessus n'est pas n'est pas facile, alors que la vérification de la $L p$-$m$-approximabilité est presque comme le montrent nos exemples ci-dessous. Ceci est dû au fait que la condition de $L p$-$m$-approximabilité utilise directement la spécification du modèle $X_n = f (epsilon.alt_n , epsilon.alt_(n-1), ...)$. Un autre problème est que même lorsque le mélange s'applique (par exemple, pour les processus de Markov), il nécessite généralement des conditions de régularité fortes et strictes.

  #align(right)[- Siegfried Hörmann and Piotr Kokoszka #cite(label("10.1214/09-AOS768"))]
]

Les processus qui nous intéressent et ceux auxquels on va se limiter dans un premier temps sont les processus causaux. Comme dans le cas réel, on peut étudier les séries temporelles en posant l'opérateur :

$ B : x_n |-> x_(n-1) $

et la relation de dépendance encodée par :

$ X_(n-1) = phi.alt(X_n) + xi_n quad phi.alt thin sans("linéaire") $

Si le processus est inversible, on peut écrire $X_n$ comme le développement en série entière suivant :

$ X_n &= phi.alt compose B (X_n) + xi_n \
  [I - (phi.alt compose B)] (X_n) &= xi_n \
  X_n &=_(norm(phi.alt compose B) < 1) inverse((phi.alt compose B)) (xi_n) \
  X_n &=_(sum sans("E")) sum_(k=0)^infinity underbracket([phi.alt compose B]^k, phi.alt^k compose B^k) (xi_n) $

En effet, les opérateurs $phi.alt$ et $B$ commutent car :

$ x = (x_n)_(n in ZZ) = (dots.h, x_0, x_1, x_2, dots.h) $

$ phi.alt(x) = (dots.h, phi.alt(x_0), phi.alt(x_1), phi.alt(x_2), dots.h) $

on a bien $phi.alt compose B = B compose phi.alt$

$ phi.alt compose B (x) &= (dots.h, phi.alt compose B (x_0), phi.alt compose B (x_1), phi.alt compose B (x_2), dots.h) \
  &= (dots.h, phi.alt(x_(-1)), phi.alt(x_0), phi.alt(x_1), dots.h) \
  &= (dots.h, B(phi.alt(x_0)), B(phi.alt(x_1)), dots.h) \
  &= B(phi.alt(x)) $

et ainsi

$ mathbox(X_n = sum_(k=0)^infinity phi.alt^k (xi_(n-k)) = f(dots.h thin xi_(n-k) thin dots.h mid(|) k gt.eq 0)) $

Cela nous donne déjà une bonne idée de l'idée derrière la génération d'un processus Brownien multi-fractionnaire utilisé pour les simulations lors de ce stage.

#definition(name: [copie indépendante])[
  on appelle $V$ une copie indépendante de $U$ si $V tilde U tilde cal(L)$ ET $V indep U$.

  i.e : $U$ et $V$ sont de même loi et indépendantes. Exemple : même étude réalisée à deux laboratoires différents avec des patients différents.
]

soit maintenant

$ Xi_n isdef { xi_n }_(-infinity : n) quad sans("la suite de bruits blancs dans l'inversion précédente") $

On va regarder le niveau de dépendance de $X_n$ à l'ordre $a$. Pour cela nous allons commencer par effectuer une copie indépendante du bruit pour chaque ordre $a$ que nous allons regarder. L'idée est que l'on ne va garder que les $a$ derniers termes de notre processus dont on souhaite savoir jusqu'à combien de termes la dépendance avec le passé est significative. Les termes qui les précèdent seront remplacés par une copie indépendante qui n'a donc pas pu avoir d'influence sur les $a$ derniers termes (par copie _indépendante_) : les termes que l'on a conservé ne peuvent pas dépendre de la copie.

#grid(
  columns: (0.47fr, 0.47fr),
  column-gutter: 1fr,
  align(horizon)[
    $ Xi^([1]) &= limits(op("copy"))_indep Xi \
      dots.v quad &quad quad dots.v \
      Xi^([a]) &= limits(op("copy"))_indep Xi \
      dots.v quad &quad quad dots.v \
      Xi^([infinity]) &= limits(op("copy"))_indep Xi $
  ],
  align(horizon)[
    $ X_n^((a)) = f(
        underbracket(#[$xi_n, thin xi_(n-1), thin dots.h$], a med sans("termes")),
        thin overbracket(
          underbracket(#[$xi_(n-a)^([a]), thin dots.h, thin xi_1^([a])$], sans("tronqué ") a sans(" derniers termes")),
          a^sans("ème") thin limits(op("copy"))_indep sans(" de ") (Xi_n)
        )
      ) $
  ],
)

Ensuite il nous suffit de regarder si on a perdu beaucoup d'information sur le processus en le comparant au processus initial, dont on souhaite déterminer l'ordre de dépendance. On regarde le pire cas pour $t in cal(T)$ :

$ L_p (X_n mid(|) a) = esperance(norme(infinity(cal(T)), X_n - X_n^([a])))^p $

On parle alors de $bb(L)^p - a$#footnote[ajout post-soutenance : le papier appelle cela la «#h(0.1em)$bb(L)^p_C - a$#h(0.1em)» approximation en rajoutant un $C$ car il s'agit de la définition proposée par Hormann et Kokoszca *mais en remplaçant la norme $bb(L)^2$* (utilisée par Hormann et Kokoszca) *par la norme de la convergence uniforme pour les fonctions #emph[C]ontinues*] approximation en étudiant la convergence de la série :

$ sum_(a=1)^infinity L_p (X_n mid(|) a)^(1/p) = sum_(a=1)^infinity (esperance(norme(infinity(cal(T)), X_n - X_n^([a])))^p)^(1/p) $

#definition(name: [$bb(L)^p - a$ approximation])[
  une suite de variables aléatoires $suite(X,i)$ est dite $bb(L)^p - a$ approximable si la série $display(sum_(a=1)^infinity L_p (X_n mid(|) a)^(1/p))$ converge.
]

#idee[
  #orangeboxed[✎ section ajoutée :]

  La convergence de série est très restrictive et impose une vitesse de décroissance rapide pour assurer la convergence.

  En n'oubliant pas que $u_n arrow.r 0 arrow.r.double.not sum u_n < infinity$, la convergence de la série définie ci-dessus nous dit que la suite des pires écarts entre un processus causal et son approximation en enlevant toutes les dépendances après l'ordre $a$ converge suffisamment rapidement vers $0$ lorsque $a arrow infinity$. Et donc qu'en ne regardant que les pires cas, il faut que le processus d'approximation ressemble très vite au processus de départ d'où la «#h(0.1em)dépendance faible#h(0.1em)» et la $bb(L)^p - a-$approximation.
]

Il s'agit de la définition de dépendance faible proposée pour les données fonctionnelles par Hörmann et Kokoszka#cite(<weakly-dependent-functional-data>). Une autre définition est aussi populaire : aulieu de remplacer tout le passé par la copie, on ne remplace que $xi_0$ par la $a^sans("ème")$ copie.

L'idée est qu'après inversion du processus causal on obtient les approximations en remplaçant les termes d'ordre $k$ :

$ X_n &= sum_(k=0)^(a-1) phi.alt^k (xi_(n-k)) + sum_(k=a)^infinity phi.alt^k (xi_(n-k)) \
  limits(X_n^([a]))_(colorize([k gt.eq a])) &isdef sum_(k=0)^(a-1) phi.alt^k (xi_(n-k)) + colorize(sum_(k=a)^infinity phi.alt^k (xi_(n-k)^([a]))) \
  limits(X_n^([a]))_(colorize([k = n])) &isdef sum_(k eq.not n)^infinity phi.alt^k (xi_(n-k)) + colorize(phi.alt^n (xi_0^([a]))) $

Le reste dans l'approximation $bb(L)^p - a$ de $X_n$, $R_n^([a])=(X_n - X_n^([a]))$, devient alors le suivant :

$ X_n &= sum_(k=0)^(a-1) phi.alt^k (xi_(n-k)) + sum_(k=a)^infinity phi.alt^k (xi_(n-k)) \
  limits(R_n^([a]))_([k gt.eq a]) &limits(=)_(phi.alt sans(" lin")) sum_(k=a)^infinity phi.alt^k (xi_(n-k)^([a]) - xi_(n-k)) \
  limits(R_n^([a]))_([k = n]) &= phi.alt^n (xi_0^([a]) - xi_0) $

et on peut alors montrer que pour une certaines métrique $nu_2$ basée sur la norme $bb(L)^2$,

$ nu_2 (limits(R_n^([a]))_([k gt.eq a])) lt.eq C sum_(a in A) nu_2 (limits(R_n^([a]))_([k = n])) $

ce qui fait de la dernière version introduite est une version plus forte. Avec la dernière définition introduite, il avait été démontré différentes inégalités qui se trouvent très utiles pour déterminer les bornes de concentration de différents estimateurs. La question est désormais la suivante :

#question(align(center)[«#h(0.1em)est ce que ces inégalités restent vraies pour la définition $limits(X_n^([a]))_([k gt.eq a])$ ?#h(0.1em)»])

La réponse, déterminée par MPV #cite(<maissoro-SmoothnessFTSweakDep>) est oui. C'est important de l'avoir aussi pour cette définition car MPV a réussi à étendre la notion de $bb(L)^p - a$ approximation au cas de la $norme(infinity, dot.op)$#footnote[Correction post-soutenance : petite erreur d'inattention qui peut avoir une grosse erreur d'interprétation, on prend bien ici la norme qui provient de l'espace de Banach $(cal(C)^0 (I, bb(R)) , norme(infinity, dot.op))$] (norme de la convergence uniforme pour les fonctions continues sur un compact) #cite(<maissoro-SmoothnessFTSweakDep>) pour avoir un héritage local de la notion de dépendance définie sur les trajectoires.

#question[
  N'est-il pas bizarre qu'une norme infinie permette de définir une notion de dépendance locale ?
]

Il semble en effet plus que contre-intuitif qu'une norme infinie, c'est à dire une norme invoquant le supremum sur un intervalle, permette d'obtenir une notion de dépendance locale.

en notant $nu_p : x |-> esperance(abs(x)^p)^(1/p)$

$ sum_n esperance(abs(X_n colorize((t), color: flat.at("red-light")) - X_n^([a]) colorize((t), color: flat.at("red-light")))^p) lt.eq sum_n esperance(distnorme(infinity(cal(T)), X_n, X_n^([a]))^p) $

La somme des $nu_P (abs(dot.op (t)))$ étant bornée par la somme des $nu_P (norme(infinity, dot.op))$, la dépendance locale (ie à $t$ fixé) est directement héritée.
Si la démarche consistait juste à obtenir une notion de dépendance locale, on remarque que ce qui la fait marcher est le fait que l'on a la convergence en considérant les pires cas sur chaque trajectoire.

#warn[
  Démontrer que $display(sum_n esperance(abs(X_n colorize((t), color: flat.at("red-light")) - X_n^([a]) colorize((t), color: flat.at("red-light")))^p) < infinity) quad$ $t$ par $t$ ne suffit pas pour que les résultats sur l'obtention de la régularité découlent :

  il est important de définir les hypothèses de données fonctionnelles sur les fonctions et non pas sur les valeurs prises par les fonctions. Puisque c'est la réplication des courbes qui est la clé.
]

L'idéal serait d'avoir une notion de dépendance faible qui permettrait d'obtenir une inégalité du genre :

$ sum_n nu_p (distnorme(sans("hypothétique")_(inf), X_n, X_n^([a]))) lt.eq sum_n nu_p (abs(X_n (t) - X_n^([a])(t))) lt.eq sum_n nu_p (distnorme(sans("hypothétique")_(sup), X_n, X_n^([a]))) $

Qui donnerait une sorte d'équivalence entre le point de vu fonctionnel et le point de vue local en terme de dépendance, mais à ce jour, et à notre connaissance, il n'existe pas de telle notion de dépendance.

#question[
  Si l'on souhaite juste regarder l'ordre de dépendance, en remplaçant l'information après le $a^sans("ème")$ dernier terme par quelquechose dont le processus qui nous intéresse ne dépend pas, pourquoi s'embêter avec des copies indépendantes aulieu de simplement tronquer (c'est-à-dire remplacer par des $0$) ?
]

Il s'avère que les deux définitions sont en quelques sorte «#h(0.1em)équivalentes#h(0.1em)» mais que celles avec les copies est plus générale et donc est évidemment privilégiée pour plus de flexibilité et de puissance dans les résultats dérivés.

$ X_n &= sum_(k=0)^(a-1) phi.alt^k (xi_(n-k)) + &sum_(k=a)^infinity phi.alt^k (xi_(n-k)) \
  limits(X_n^([a]))_([k lt.eq a]) &= sum_(k=0)^(a-1) phi.alt^k (xi_(n-k)) + &sum_(k=a)^infinity phi.alt^k (xi_(n-k)^([a])) \
  limits(X_n^([a]))_([k = n]) &= sum_(k=0)^(a-1) phi.alt^k (xi_(n-k)) + &0 $

et ainsi lorsque l'on va regarder

$ norme(infinity(cal(T)), X_n - X_n^([a]))^p = norme(infinity(cal(T)), sum_(k=a)^p phi.alt^k (xi_(n-k) - xi_(n-k)^([a])))^p $

que ce soit avec une méthode ou l'autre, on remarque que lorsque l'on va développer les sommes, les termes en $norme(infinity(cal(T)), xi dot.op xi^([a]))$ seront nuls.
