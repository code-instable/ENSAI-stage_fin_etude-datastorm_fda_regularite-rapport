// ~ src/content/chapter_1/__main__.tex
#import "../lib/math.typ": *
#import "../lib/components.typ": info, question, colorize, fbox
#import "../lib/plot.typ": weierstrass, plot-2d
#import "../lib/theme.typ": flat

= Motivations

Dans le cadre de ce stage, les données que l'on traite sont des données du secteur de l'énergie, et plus particulièrement des données de production électrique. On dispose ainsi de plusieurs éoliennes identifiées par le tag "id\_[identifiant de l'éolienne]" dont l'énergie produite est mesurée toutes les demies heures, et ce pendant 4 ans (de de 2014 à 2017).
Cette énergie produite est dénommée la courbe de charge (que l'on abbrégera par *CDC* par la suite). Il est cependant plus utile de s'intéresser au facteur de charge (ou *FDC*) qui est défini comme

$ sans("Facteur de Charge") = sans("Courbe de Charge") / sans("Puissance Installée") . $

On en déduit que *FDC* doit nécessairement être compris entre 0 et 1. C'est entre autre aussi une manière de détecter des anomalies et données atypiques comme la surproduction d'énergie par rapport à ce qui était attendu de la part d'un parc éolien ou encore un défaut de capteur (tension / intensité, ...) qui mesure la courbe de charge. Voici notamment l'exemple de données éoliennes :

#align(center)[
  période : Première semaine de Juin 2015

  #image("/src/Images/motivation/data_eol-week.jpg", width: 85%)
]

#figure(
  align(center)[
    période : Juillet 2015

    #image("/src/Images/motivation/data_eol.jpg", width: 85%)
  ],
  caption: [Courbes de facteur de charge éolienne sur 3 parcs éoliens],
  kind: image,
  supplement: [Figure],
) <fig:courbes_de_charge>

#v(1em, weak: true)

Les données qui sont traitées dans le cadre de ce stage sont, entre autres, des courbes de charge observées chaque demie-heure de production électrique éolienne ou photovoltaïque. Le schéma d'observation est donc le «#h(0.1em)common-design#h(0.1em)». C'est-à-dire que les temps d'observation sont ici déterministes à intervalle de temps fixe.

== Difficulté de modélisation de la dynamique des données par un modèle de série temporelle classique <sec:difficulte-modele-serie-temporelle>

Une première idée serait d'utiliser un modèle de série temporelle ARIMA afin de modéliser la dynamique des courbes de charge. Bien que de nombreux outils aient été développés pour les séries temporelles#footnote[_cf_ annexe #ref(<annexe:histoire>) sur l'histoire des séries temporelles], ces modèles présentent des limites en termes de prédiction à long terme, les rendant moins utiles lorsque l'objectif est de prédire à moyen ou long terme. De plus, ils partagent avec la plus part des modèles de machine learning populaires le fait d'estimer les données courbe par courbe ce qui ne tire pas profit du fait que les observations aient une forme similaire entre les courbes.

Même si naturelle, l'utilisation d'un modèle ARIMA ne permet de modéliser la dynamique du phénomène que l'on s'est donné à étudier. En effet, la sélection d'un modèle ARIMA sur le critère du BIC résultait, peu importe le parc éolien, en un modèle auto-régressif d'ordre 0. _Ainsi le modèle sélectionné considérait les irrégularités de la courbe de charge, dont on attend que le processus duquel elle est issue soit irrégulier (de par sa complexité), comme étant du bruit_. On en conclut que ces modèles peuvent ne pas capturer efficacement la structure complexe des données.

#fbox[
  Si l'on souhaite potentiellement mieux prédire, il serait donc souhaitable de pouvoir d'estimer la régularité des données et de la prendre en comtpe dans le modèle. Afin de mieux modéliser nos données, nous allons donc adopter une approche basée sur les données fonctionnelles pour capturer la structure de la courbe de charge. Cette approche permettra de d'exploiter une information clé : la similarité entre les courbes observées.
]

== Les données fonctionnelles comme solution à cette difficulté <sec:donnees-fonctionnelles>

#question[
  #align(center)[
    #v(1em, weak: true)
    Qu'est-ce qu'une donnée fonctionnelle ?
  ]
]

Une donnée est dite fonctionnelle lorsque la variable aléatoire qui nous intéresse n'est plus une variable aléatoire à valeur dans $bb(R)^d$, comme le statisticien a l'habitude de manipuler, mais une variable aléatoire à valeur dans un espace de fonction. Concrètement, chaque réalisation n'est plus un nombre mais bien une courbe toute entière à support (le plus souvent) sur un intervalle $cal(T)$.

#figure(
  image("/src/Images/motivation/donneesRvsFD.jpg", width: 85%),
  caption: [Différence entre donnée fonctionnelle et donnée réelle],
  kind: image,
  supplement: [Figure],
) <img:RvsFD>

Si le statisticien est déjà à l'aise avec l'idée qu'une variable aléatoire réelle identiquement distribuée puisse modéliser une expérience répétable provenant d'un même phénomène, il pourra se convaincre que les données fonctionnelles permettent elles aussi de modéliser des expériences en lien (fonctionnel) avec un certain paramètre. Et c'est le lien entre les deux valeurs, cette fois-ci, qui provient d'un même phénomène.

Donnons en un exemple : observons la consommation électrique d'un foyer dans une journée. Lorsque l'on travaille sur $bb(R)$, on s'intéresse à sa consommation électrique disons en l'instant $t = 12 sans("h")$. Formellement :

$ cal(T) thin isdef [thin 0,24 thin[ quad (= sans("1 jour avec ") t sans(" en heure")) $

La consommation du foyer $i$ à midi, notée $y_i$, suit la loi d'un phénomène général $Y$, comme une loi normale $cal(N) (0.27 thin thin k W sans(h), 0.1^2)$#footnote[ordre de grandeur de la consommation électrique d'un foyer en France calculé à partir des données d'ENGIE disponibles librement #cite(<engie-data-conso-moy-par-an>). *La variance est arbitraire*, tout comme le choix de la loi juste afin de servir d'exemple.] par exemple. Travailler sur des données fonctionnelles dans ce cadre c'est étudier non plus la consommation $y_i$ à midi, mais regarder l'ensemble de sa consommation en même temps sur toute la journée ${ y_i = x_i (t) sans(" avec ") t in cal(T) }$.

On remarque ainsi que toutes les consommations électriques le long de la journée d'un foyer à l'autre suivent la même tendance : on consomme plus le matin avant le travail et le soir alors que pendant la journée on consomme moins car on est au travail. Ainsi c'est la fonction $x_i : cal(T) limits(->) bb(R)$ qui suit la loi d'un phénomène $X$ général. Ce que l'on vient de dire c'est que la *relation* entre le temps $t in cal(T)$ et la consommation électrique ${thin y_i (t) thin}$ est elle même sujet à une loi plus générale. Grossièrement, les courbes auront la même allure, mais chaque individu a sa consommation propre.

Plus formellement : comme on a défini une variable aléatoire réelle comme une application :

$ func(Omega, bb(R), omega, x = X(omega)) $

On définit de même une donnée fonctionnelle comme une application :

$ func(Omega, colorize(cal(C)^0 (cal(T), bb(R))), omega, x = X(omega)) $

Ce que l'on observe sont donc les valeurs des paramètres $t in cal(T)$ ainsi que l'image de $t$ par $x$ : $y = x(t)$. Les points que le statisticien observe sont donc les couples de la forme $(t_k^((sans("individu ") i)), y_k^((sans("individu ") i)))_(i in intervaleint(1, m))$, générés par le processus aléatoire $X$ dont la réalisation est la véritable courbe $x_i$ de l'individu $i$ que l'on souhaite estimer pour travailler avec.

#info[
  Il existe différentes façons de définir les données fonctionnelles, une définition possible est la suivante:

  $ Omega times cal(T) limits(->) bb(R) \ (omega, t) limits(|->) X(omega, t) = y $

  Cependant, cette représentation ne permet pas une interprétation clé en main du concept mais est certainement plus commode à manipuler pour les mathématiciens dans certains contextes. Cette approche est un point de vue de type "processus stochastique" et diffère du point de vue "élément aléatoire" comme traité de façon claire dans #cite(<HsingEubankTheoreticalFoundationsOfFDA>).
]

Maintenant que l'on possède une meilleure intuition de ce que sont les données fonctionnelles, il est naturel de se demander pourquoi le choix de modéliser notre phénomène par des données fonctionnelles serait particulièrement judicieux. Pour cela, rappelons nous les difficultés que l'on avait rencontrées dans le cadre de nos données de production électrique en utilisant un modèle de série temporelle classique :

#info[
  *Rappel : *

  "$[dots.h]$ le modèle #colorize[(arima)] sélectionné considérait les irrégularités comme étant du bruit $[dots.h]$ Afin de prédire sur le long terme, nous allons donc adopter une approche basée sur les données fonctionnelles pour capturer la structure de la courbe de charge $[dots.h]$"
]

#question[
  #v(0.3em, weak: true)
  #align(center)[
    Pourquoi est-ce que l'on s'intéresse autant à la régularité des données que l'on étudie ici ? Et surtout, en quoi est ce que les données fonctionnelles vont nous permettre de mieux capturer la régularité ?
  ]
]

== Importance de l'estimation de la régularité <sec:importance-estimation-regularite>

Comme mentionné auparavant, la production électrique est un phénomène très irrégulier [figure #ref(<fig:courbes_de_charge>)] étant influencé par la consommation, la météo, etc. Par conséquent, la prévision de ces courbes de charge doit prendre en compte la nature fondamentalement irrégulière du phénomène afin de proprement le modéliser et, en définitive, mieux le prédire.
Ce qui est notamment contraire à de nombreux modèles populaires parmi les statisticiens qui utilisent des fonctions de classe $cal(C)^2$ pour lisser les points observés en données fonctionnelles, ce qui limite la prédiction à des courbes de nature $cal(C)^2$.
Cela est d'autant plus critique lorsque l'on cherche à estimer le processus moyen ou l'opérateur de covariance du processus, car ces derniers sont estimés à partir des courbes lissées.
Le lissage détruit alors toute l'information irrégulière si elle n'est pas prise en compte et ainsi impacte significativement l'estimation des objets qui nous intéressent en tant que statisticien.

#figure(
  plot-2d(
    size: (11, 6),
    x-range: (0, 1.05),
    y-range: (-0.4, 0.4),
    curves: (
      (fn: x => weierstrass(2 * x, 2, 15), domain: (0, 1.05), samples: 800, color: flat.green, stroke: 0.7pt),
      (fn: x => 0.37 * calc.sin(2 * calc.pi * x), domain: (0, 1.05), samples: 200, color: flat.orange, stroke: 0.7pt),
    ),
    legend: (
      (color: flat.green, label: [$cal(C)^0$]),
      (color: flat.orange, label: [$cal(C)^infinity$]),
    ),
  ),
  caption: [Comparaison entre une courbe $cal(C)^infinity$ et une courbe non dérivable],
  kind: image,
  supplement: [Figure],
) <fig:continu_vs_c_deux_1>

Il est ainsi important pour des phénomènes de nature irrégulière de ne pas négliger des précautions lors du lissage afin de ne pas perdre l'information irrégulière. L'idée est donc d'estimer dans un premier temps la régularité de notre processus afin de lisser nos données de manière adaptée. Il est alors possible prédire des valeurs non observées tout en préservant les informations irrégulières. Cela permet enfin d'obtenir une bonne estimation du processus moyen et de l'opérateur de covariance. L'approche fonctionnelle est clé dans l'estimation de cette régularité, car c'est la *réplication de courbes* de même nature qui permet in-fine d'*estimer la régularité* du phénomène, et il est donc important de bien savoir l'estimer.

== Importance du choix du voisinage utilisé pour l'estimation de la régularité <sec:importance-choix-voisinage>

#question[
  L'estimation de la régularité des trajectoires est certes importante mais comment l'estime-t-on en pratique ?
]

Dans le cadre de données avec dépendance faible, il est possible d'estimer la régularité locale du processus ponctuellement en utilisant les informations d'un voisinage arbitrairement donné#footnote[L'étude de la convergence des estimateurs des paramètres de régularité locale a été établie par Golovkine et al. ainsi que Maissoro-Patilea-Vimond#footnote[qui seront désormais mentionnés par «#h(0.1em)MPV#h(0.1em)»] #cite(<golovkineRegularityOnlineEstimationNoisyCurve>) #cite(<maissoro-SmoothnessFTSweakDep>).]. Cependant bien que l'estimateur soit convergent en utilisant un voisinage quelconque, il n'est pas spécifié de quelle taille devrait être ce voisinage pour avoir une bonne estimation des paramètres de régularité locale#footnote[On entend par bonne estimation une estimation qui comporte les caractéristiques suivantes : une bonne vitesse de convergence, un compromis biais-variance adapté à l'application souhaitée de notre estimateur]. On appelle le diamètre du voisinage que l'on considère pour effectuer les calculs «#h(0.1em)$Delta$#h(0.1em)».

#question[
  Si la convergence des estimateurs est déjà déterminée pour un $Delta$ donné arbitraire, pourquoi ne pas simplement en prendre un de façon arbitraire ?
]

Choisir un diamètre de voisinage non approprié mènerait à utiliser des informations non pertinentes pour estimer la régularité car celle-ci peut être variable sur l'ensemble de la trajectoire. De plus, il est naturel de penser que différents niveaux de régularités requièrent de regarder des informations d'une proximité différente.#footnote[Considérer $|x - x_0| = Delta$ dans la définition de la régularité que l'on considère en #ref(<annexe:regularite-def>)] On introduirait alors un biais significatif dans l'estimation des paramètres de régularité locale, dont on a vu qu'il était important de bien estimer.

== Objectif du stage <sec:objectif-stage>

Choisir le bon diamètre du voisinage $(Delta)$ que l'on considère pour estimer la régularité locale est donc un problème important, et c'est ce que l'on va étudier lors de ce stage. L'objectif est d'obtenir une procédure de détermination du $Delta$ que le praticien devra choisir pour l'estimation de la régularité locale en fonction de quantités facilement estimables, comme nombre moyen de points observés par courbe par exemple.

Pour cela, on simulera 200 réplications indépendantes de monte-carlo d'un modèle auto-régressif fonctionnel dont les bruits blancs sont des mouvements browniens multi-fractionnaires de régularité variable connue. Les estimateurs de régularité fournis par MPV #cite(<maissoro-SmoothnessFTSweakDep>) seront ensuite utilisés pour estimer la régularité (connue) de ces courbes. La procédure de sélection du $Delta$ sera alors déterminée en s'appuyant sur l'analyse du comportement d'un risque d'estimation de la régularité en fonction du $Delta$ choisi. Enfin la procédure déterminée sera testée sur les données simulées avant d'être appliquée sur des données réelles pour estimer de façon adaptative la fonction moyenne.
