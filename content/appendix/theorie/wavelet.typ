// ~ src/content/appendix/theorie/wavelet.tex
#import "../../../lib/math.typ": *
#import "../../../lib/components.typ": info, brain, mathbox
#import "../../../lib/theorems.typ": prop, definition, thm

#info[
  Ceci regroupe les éléments théoriques pour la compréhension de la recommendation d'étude de la base ondelettes pour le prélissage lors de l'estimation de la régularité. Pour plus de détails sur les motivations on pourra se référer à l'annexe #ref(<annexe:lissage_base_fcn>) ainsi que la discussion méthodologique en section #ref(<sec:methodo_discussion>).
]

=== Transformée en ondelettes

Introduisons maintenant de façon plus formelle les ondelettes et regardons leurs propriétés intéressantes dans le cadre du lissage de trajectoires.

on définit la transformée en ondelettes vis à vis de l'ondelette mère $psi$ d'une fonction $f$ par :

$ F : func(bb(R) times Rplus, bb(R), (t,s), display(1/sqrt(abs(s)) integral_bb(R) f(u) psi(frac(u-t,s)) upright(d) u)) $

#brain[on peut remarquer que la formule de la transformée en ondelettes ressemble à une projection : $display(prodscalselon(f,psi_(t,s),bb(L)^2)/norme(med,psi_(t,s)))$. Cela vient en quelque sorte motiver la section suivante]

==== Base d'ondelettes

#prop(name: [base d'ondelette dichotomique])[
  $ { psi_(k,n) : t |-> 1/sqrt(2^k) psi(frac(t - 2^k n, 2^k)) }_((k,n) in ZZ^2) sans(" est une base ") orthonormal sans(" de ") bb(L)^2 $
]

#info[notons que les résolutions sont des puissances de 2, ceci est un détail qui demandera une implémentation particulière dans le cadre des données réelles : il faudra faire attention à ce que le nombre de points que l'on donne dans l'algorithme de transformée rapide en ondelettes soit aussi une puissance de 2.]

=== Propriétés principales des ondelettes

==== Approximation dans l'espace fréquentiel-temporel

La transofrmée en ondelettes

$ cal(W) : f |-> prodscal(f, psi_(t,s)) $

est une isométrie de $bb(L)^2$. Étant donné qu'elle est de plus une application linéaire, nous pouvons donc d'affirmer que

$ mathbox(norme(bb(L)^2, f - hat(f)) = norme(bb(L)^2, cal(W) f - cal(W) hat(f))) $

Ainsi on peut travailler dans l'espace des ondelettes pour approximer (dans notre cas lisser les trajectoires) des fonctions et contrôler l'approximation directement dans le domaine fréquence-temporel tout en le conservant dans le domaine temporel.

==== Propriété de Fast Decay : [ref : #cite(<mallat-wavelet-course-ens-wavelet-zoom>)]

Une caractérisation des fonctions Hölderiennes, fournie par Antoniadis et Gijbels en 2002 est :

$ f in cal(H)_(cal(V)(t_0)) (alpha, L_alpha) inter bb(L)^2 <==> thin & exists P in bb(R)[X], thin op("deg") P lt.eq alpha lt.eq op("deg") P + 1 \
  & exists f_(l o c) limits(=)_(t arrow 0) cal(O)(t^alpha) \
  quad f(t_0 + h) limits(=)_(t arrow 0) P(h) + f_(l o c)(h) $

#definition(name: [vanishing moment])[
  on dit qu'une ondelette $psi$ possède $n$ vanishing-moments si :

  $ forall k < n quad prodscalselon(t |-> t^k, psi, bb(L)^2) = 0 = integral_bb(R) t^k psi(t) thin d t $
]

#prop(name: [vanishing-moment et polynômes])[]

il suffit donc de choisir une ondelette avec $n > alpha$ vanishing-moments pour obtenir :

$ cal(W) f_(mid(|) cal(V)(t_0)) = cal(W) (P + f_(l o c)) = cal(W) P + cal(W) f_(l o c) = cal(W) f_(l o c) $

enfin

#thm(name: [Fast Decay | ref : #cite(<mallat-wavelet-course-ens-wavelet-zoom>) - thm 6.3])[
  $ f in cal(H)_(cal(V)(t_0)) (alpha, L_alpha) inter bb(L)^2 ==> exists A>0, thin abs([cal(W) f](t,s)) lt.eq A dot.op s^(alpha + 1/2) $

  et inversement en supposant $f$ bornée (ce qui est le cas pour une fonction continue sur un segment : notre cas) et $f$ Hölder juste après les bords. (C'est à dire que ça ne marche pas pour les points extrémaux $t in {0, 1}$)
]

Ainsi lorsque $s in {2^(-k)}_(k in bb(N))$ :

$ abs([cal(W) f](t,s)) lt.eq A dot.op 2^(-k(alpha + 1/2)) $

La magnitude de la transformée en ondelette décroit exponentiellement vers 0, et beaucoup plus rapidement là où $f$ est plus régulière. Ainsi, la transformée en ondelette agit comme un encodeur efficace d'information d'irrégularité.

=== Discussion : potentiel du lissage ondelette pour le prélissage

L'information que «#h(0.1em)l'on garde le plus#h(0.1em)» lorsque l'on effectue une transformée en ondelette est l'information irrégulière. Cela peut être vu comme en traîtement du signal, où l'on souhaite encoder les bits d'informations qui «#h(0.1em)nous surprennent#h(0.1em)» et non pas ceux qui sont prédictibles (redondance, ... ). L'information d'irrégularité est l'information qui se «#h(0.1em)comporte moins bien#h(0.1em)» et représente donc l'information que l'on souhaite prioriser. C'est pourquoi, comme mentionné en annexe #ref(<annexe:lissage_base_fcn>), si l'on souhaite utiliser pour des raisons pratiques ou imposées par le client, une base de fonctions pour effectuer le pré-lissage, on pourrait étudier l'efficacité de la base ondelettes sur un tel pré-lissage et comparer les résultats obtenus avec ceux obtenus avec une base de fonctions plus classique (polynômes locaux, splines, ...).
