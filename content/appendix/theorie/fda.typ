// ~ src/content/appendix/theorie/fda/{essentiel.tex,content/def_fda.tex,content/thm_KL.tex}
#import "../../../lib/math.typ": *
#import "../../../lib/components.typ": info, mathbox
#import "../../../lib/theorems.typ": definition, thm, preuve, rem

==== Définition formelle

Pour éviter d'alourdir les notations, on se place dans le cas où les fonctions sont à valeurs dans $bb(R)$ et à support sur un intervalle fermé $I$ de $bb(R)$. Toutefois, on peut très bien considérer des fonctions à valeurs dans $bb(R)^d$ et à support sur un compact $K$ de $bb(R)^p$ sans perte de généralités.

#definition(name: [données fonctionnelles])[
  On appelle données fonctionnelles, un échantillon $famfinie(x, 1, n)$ de fonctions continues $x_i : I -> bb(R)^d$ issues d'un processus $X$ défini comme ci-dessous :

  $ X : func(Omega, cal(C)(I, bb(R)), omega, X(omega) = x) $
]

==== Résultats importants pour les données fonctionnelles

#info[Cette section motive le souhait de bien estimer la régularité locale et la fonction moyenne en prenant compte de la régularité locale car utile pour l'estimation de la covariance. Cette covariance est centrale en données fonctionnelles. *Le lecteur n'a pas besoin de lire cette partie pour comprendre le sujet* mais elle reste un complément intéressant pour les motivations et la compréhension de l'utilisation pratique des données fonctionnelles.]

Si le stage se concentre sur l'estimation du couple d'incréments quadratiques, utilisé pour estimer la régularité locale et son application pour l'estimation de la moyenne, la bonne estimation de la covariance des données fonctionnelles est essentielle. En effet, les résultats énoncés ci-dessous permettent de travailler sur des données fonctionnelles à partir de nombres réels que l'on sait bien mieux manipuler. Ils permettent enfin d'approximer les objets de notre modèle (les fonctions continues) vivant dans un espace vectoriel de dimension infinie en établissant une «#h(0.1em)base#h(0.1em)» qui représente au mieux, avec un nombre fixé de composantes nos données.

#rem[
  on notera que dans le cadre des données fonctionnelles, on ne travaille pas de façon générale avec la covariance :

  $ C_X : (s,t) |-> esperance([X - mu](s) dot [X - mu](t)) $

  On travaille plutôt avec l'*opérateur* de covariance :

  $ c : func(bb(L)^2, bb(L)^2, f, integral_I f(u) C_X (u, dot.op) thin d u) $

  C'est parceque cet opérateur est dans un premier temps une application de $bb(L)^2$ dans $bb(L)^2$, ce qui est important lorsqu'on se place du point de vue «#h(0.1em)objet aléatoire#h(0.1em)», les hypothèses et tous les objets que l'on considère manipulent directement les vecteurs de l'espace d'arivée. D'autre part, il est linéaire continu#footnote[car Hilbert-Schmidt donc borné pour la norme d'opérateur] symétrique semi-défini positif#footnote[pour le produit scalaire de $bb(L)^2$], on peut donc en faire une décomposition spectrale sur une base orthonormale de vecteurs propres de $bb(L)^2$ associés à des valeurs propres positives. Cette décomposition est à la base des approximations que le praticien effectuera ainsi qu'à la base de la dérivation de nombreux théorèmes et propriétés.
]

Étant donné que l'on traîte des données fonctionnelles, on considère la géométrie usuelle de $bb(L)^2 (bb(R), med lambda)$ et on note ainsi

$ prodscalselon(dot.op, dot.op, bb(L)^2) : func(bb(L)^2 times bb(L)^2, bb(R), (f,g), integral f(u) g(u) thin d lambda (u)) $

le produit scalaire que l'on considère pour manipuler les données fonctionnelles.

On énonce désormais le théorème central de l'analyse de données fonctionnelles qui n'est autre que la décomposition dans la base FPCA de notre processus.

#thm(name: [Karhunen-Loeve], key: "thm:KL")[
  _référence :_ #cite(<kokoszka2017introduction>, supplement: [pages : 238-239-241])

  *Hypothèses :*

  #align(center, mathbox(
    $ #table(
      columns: (auto, 1fr),
      stroke: none, inset: (x: 0.6em, y: 0.5em),
      align: left,
      [→], $X in bb(L)^2 (Omega, cal(C)(I, bb(R)))$,
      [→], [$sans("covariance : ") C : func(bb(L)^2 (Omega, cal(C)(I, bb(R))), cal(C)(I^2, bb(R)), X, C_X)$],
      [], [$sans("ie : ") C_X : (s,t) |-> C_X (s,t) sans(" est continue")$],
      [\*], [$sans("opérateur covariance ") c_X [thin dot.op thin] : func(cal(C)(I, bb(R)), cal(C)(I, bb(R)), f, integral_I f(s) C_X (s, dot.op) thin d s)$],
      [→], [$sans("valeurs propres ordonnées : ") forall p gt.eq 1, lambda_(p+1) lt.eq lambda_p quad quad lambda_p, lambda_(p+1) in op("sp")(c_X)$],
      [\*], [$sans("on pose ") spvecortho(c_X)^([1,p]) isdef {phi.alt_k in spvec(c_X) sans(" associé à ") lambda_k, k in intervaleint(1,p)}$],
    ) $
  ))

  *alors :*

  #align(center, mathbox(
    $ #table(
      columns: (auto, 1fr),
      stroke: none, inset: (x: 0.6em, y: 0.8em),
      align: left,
      [→], $display(forall p gt.eq 1 quad argmin_(u_k in cal(C)(I,bb(R))) bb(E) norme(2, X - sum_(k=1)^p prodscalselon(X-mu,u_k,bb(L)^2) u_k) = spvecortho(c_X)^([1,p]))$,
      [→], [$display(X = mu + sum_(k=1)^(+infinity) prodscal(X-mu,phi.alt_k) phi.alt_k)$ #linebreak() avec $phi.alt_k in spvec(c_X)$],
    ) $
  ))
]

#preuve[
  ⚙ _preuve informelle_

  La covariance est un opérateur bilinéaire symétrique défini positif, on peut donc appliquer le théorème de Mercer (équivalent du théorème spectral) qui nous donne une base orthonormale de $bb(L)^2$ sur laquelle on va décomposer notre processus *centré*.
]

#rem[
  pour pouvoir ordonner les valeurs propres dans l'ordre décroissant, et sélectionner les composantes principales les plus informatives, il faut pouvoir réarranger l'ordre de la somme. Pour cela il faut que les valeurs propres forment une famille sommable, une condition suffisante et souvent utilisée est que $bb(E) norme(2, X)^2 < infinity$
]

#rem[
  la propriété de la section précédente sur l'aspect économe de la base FPCA découle directement de l'assertion

  $ forall p gt.eq 1 quad argmin_(u_k in cal(C)(I,bb(R))) bb(E) norme(2, X - sum_(k=1)^p prodscal(X-mu,u_k) u_k)^2 = spvecortho(c_X)^([1,p]) $

  dans le théorème de Karhunen-Loeve.
]
