// ~ src/content/appendix/histoire/histoire_fda.tex
#import "../../../lib/math.typ": *
#import "../../../lib/components.typ": info, blackboxed, citer
#import "../../../lib/theme.typ": flat
#import "../../../lib/theorems.typ": leftbar

#info[Pour une description plus complète de l'histoire du développement de l'analyse fonctionnelle, on pourra se référer à #link("https://anson.ucdavis.edu/~mueller/fdarev1.pdf")[#text(fill: flat.blue-deep)[cet article de Wang, Chiou et Müller]]#cite(<wang2016functional>)]

Bien que l'histoire du développement de l'Analyse de Données Fonctionnelles (FDA) puisse être retracée jusqu'aux travaux de Grenander et Karhunen#cite(<karhunen1946spektraltheorie>) dans les années 1940 et 1950, où l'outil a été utilisé pour étudier les courbes de croissance en biométrie, ce sous-domaine de la statistique a été étudié de manière systématique à partir des années 1980.

En effet, c'est J.O. Ramsay qui a introduit l'appellation de "données fonctionnelles" en 1982#cite(<ramsay1982data>) et qui contribuera en partie à sa popularisation. La thèse de Dauxois et Pousse en 1976 sur l'analyse factorielle dans le cadre des données fonctionnelles#cite(<dauxois1976analyses>) a ouvert la voie à l'analyse par composante principale fonctionnelle (FPCA), un outil clé pour l'étude des données fonctionnelles. La FPCA permet d'étudier des objets fonctionnels qui sont de dimension infinie, difficiles à manipuler et impossibles à observer empiriquement, en dimension finie et surtout sur $RR(d)$ que l'on connait bien.

Au cours des années 2000, de nombreux outils statistiques déjà développés pour des données à valeurs dans $RR(d)$ depuis un siècle, tels que la régression linéaire (éventuellement généralisée), les séries temporelles ou encore les modèles additifs, ont été adaptés aux données fonctionnelles.
Par exemple, les modèles de régression linéaire fonctionnelle ont été développés avec une réponse fonctionnelle#cite(<ramsay1991some>) ou scalaire#cite(<cardot1999functional>) en 1999.
Les modèles linéaires généralisés ont également été étudiés#cite(<james2002generalized>)#cite(<muller2005generalized>), avec l'estimation de la fonction de lien par méthode non paramétrique à direction révélatrice _(Single Index Model)_ récemment étudiée en 2011#cite(<chen2011single>).
Cette méthode avait déjà été utilisée en économétrie pour des données de $RR(d)$ depuis 1963#cite(<sharpe1963simplified>), et leur estimation directe a été étudiée une décennie auparavant par M.Hristache, Juditsky et Spokoiny#cite(<hristache2001direct>). De même, les modèles additifs ont été étendus aux données fonctionnelles en 1999 par Lin et Zhang#cite(<lin1999inference>).
Enfin, le livre de Bosq, #text(fill: flat.blue-devil)[Linear Processes in Function Spaces : Theory and Applications] #cite(<bosq2000linear>), publié en 2000, a contribué au développement des séries temporelles pour les données fonctionnelles.

Depuis lors, des ressources telles que l'ouvrage de Kokoszka et Reimherr, #text(fill: flat.blue-devil)[Introduction to Functional Data Analysis (2017)]#cite(<kokoszka2017introduction>), rendent la théorie et la mise en production des méthodes d'analyse et de prédiction de données fonctionnelles plus accessibles.

#blackboxed[✎ Quelques ajouts d'après la présentation de Gilbert Saporta (Lille-2024)]

#leftbar[
  On attribue souvent l'origine des données fonctionnelles, et leur première appellation à J.O. Ramsay (oups - my bad ☠), le premier à invoquer les données fonctionnelles et à utiliser un modèle de régression fonctionnel linéaire est l'un des plus célèbres statisticiens : Ronald Fisher. Pour des données faisant intervenir des phénomènes tels que la pluie, où le modèle de temps n'est pas discret mais pas continu, Fisher introduit alors la première régression fonctionnelle linéaire avec une "régression intégrale". Une bonne partie de la statistique de données fonctionnelles est éventuellement lié au développement de la branche de l'analyse fonctionnelle (dont un graphe monstreux résumant ce développement est disponible sur l'oeuvre de Jean Dieudonné dédié à l'histoire de l'analyse fonctionnelle ).
]

#citer[
  J.O. Ramsay's presidential address to the Psychometric Society conference in 1982 is often
  considered to mark the start of the development of functional data analysis as a specific field of
  statistics. Fifteen years later, Ramsay and Silverman's book coined the expression "functional data
  analysis". The roots of functional data analysis are much older and sometimes little-known, such
  as Fisher's 1923 work on integral regression. By placing functional data analysis in relation to
  functional analysis, we will study the birth of the decomposition attributed to K.Karhunen and
  M.Loève, which gave rise to functional PCA developed by J.C. Deville in 1974.

  #align(right)[— Gilbert Saporta : FDA Workshop Program #cite(<saporta-fda-workshop-lille>)]
]
