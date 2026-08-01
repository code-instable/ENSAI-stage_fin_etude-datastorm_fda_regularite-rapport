// ~ src/content/appendix/segment_unite.tex
#import "../../../lib/math.typ": *
#import "../../../lib/components.typ": info
#import "../../../lib/theme.typ": numeq

#info[Cette section est basée sur la question du Jury : «#h(0.1em)le rapport parle tout le temps de données fonctionnelles sur $[0,1]$, est ce qu'il est possible d'utiliser ce type de modèle pour des données qui ne sont pas comprises entre $0$ et $1$ ?]

Il peut sembler en effet étonnant aux premiers abords de se limiter au segment $[0,1]$ pour l'espace de départ des fonctions aléatoires. Lorsque le praticien manipule des données, il devra par exemple traîter l'ensemble d'une journée en minutes par exemple. Nous allons voir pourquoi ce n'est un problème.

Le fait que toute la théorie utilise des fonctions de $[0,1] -> bb(R)$ est purement pratique pour les calculs sans rien enlever à la généralité des résultats. La théorie est ainsi bien définie pour toute fonction d'un intervalle $I = [a,b]$ quelconque dans $bb(R)$. Cela est dû au fait que l'on peut toujours se ramener à l'intervale $[0,1]$ et de nouveau sur l'intervale $[a,b]$ par une transformation affine complètement bijective. Pour voir cela définissons l'opérateur de contraction de l'intervale $I$ :

#math.equation(numbering: numeq, block: true, $ T_I : func([a,b]=I, [0,1], x, (x - a)/(b-a) = (max I - x)/(max I - min I)) $)

#math.equation(numbering: numeq, block: true, $ T_I^(-1) : func([0,1], I = [a,b], x, a + (b-a)x) $)

Étant donné que $a eq.not b$, on dispose donc d'un isomorphisme (et même plus puissant on a un difféomorphisme) entre n'importe quel intervalle $[a,b]$ et $[0,1]$. Les résultats restent donc tous les mêmes juste en se plaçant du point de vue «#h(0.1em)du début à la fin#h(0.1em)» de l'intervale que le point de vue «#h(0.1em)commençant ici et finissant là#h(0.1em)».
