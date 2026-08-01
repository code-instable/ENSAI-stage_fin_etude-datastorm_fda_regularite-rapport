// ~ src/content/pre/abstract/{main,abstract_text}.tex
#import "../../lib/vars.typ": *
#import "../../lib/components.typ": awesomebox
#import "../../lib/theme.typ": flat

#let abstract-text = [
  Les séries temporelles sont des données omniprésentes dans l'analyse et la prédiction de données. Elles concernent de nombreux secteurs critiques allant du secteur de l'énergie à la finance. Leur étude systématique depuis 1927 (Yule) est ainsi motivée par leur importance et utilité pour la mise en production.

  Les données fonctionnelles quant à elles sont particulièrement présentes dans les données de capteurs ou à composante temporelle. Elles permettent grâce au point de vue qu'elles offrent, d'obtenir notamment de meilleures estimation sur le long terme que le point de vue réel multivarié classique. Cependant, la littérature jusqu'alors ne prenait pas en compte les différences de régularité des données traitées, ce qui pose problème pour des données peu régulières pourtant fréquemment observées.

  Ce stage porte sur l'estimation de la régularité locale des trajectoires des séries temporelles de données fonctionnelles afin d'obtenir une meilleure estimation de leur fonction moyenne et de l'opérateur d'auto-covariance. Plus spécifiquement, le stage consiste à étudier le comportement d'un hyper-paramètre utilisé lors de l'estimation de la régularité locale, et à proposer une méthode de sélection de ce dernier. Enfin cette méthode sera appliquée sur des données réelles du secteur énergétique.
]

#let abstract() = [
  #align(center)[*Résumé*]
  #v(0.5em)
  #align(center, box(
    width: 75%, stroke: 0.5pt + black, inset: 1em,
    // `align(left)` guards against the ambient `align(center)` above
    // leaking into the paragraph's own (short) last line otherwise.
    { set par(justify: true); set align(left); abstract-text },
  ))

  #v(1em)
  *contribution*
  #v(1em, weak: true)

  si jamais vous apercevez des fautes dans le polycopié, merci de rédiger une #underline[issue] sur Github à l'adresse :

  #v(1em, weak: true)
  *correctif*

  #awesomebox(flat.imperial, "🔗", align(center, text(font: "JetBrains Mono", githubissues)))
  *contact*
  #awesomebox(flat.orange-light, "@", align(center)[*mail étudiant :* #mail])

  #v(1em, weak: true)
  *⚠ Disclaimer : article de Hassan Maissoro*

  Le stage effectué se base sur les travaux de Hassan Maissoro et de son article #underline[Adaptive estimation for Weakly Dependent Functional Times Series] @maissoro2024adaptiveestimationweaklydependent. En particulier sur une version antérieure à la version finale de l'article (Le rapport de stage a été rendu approximativement 7-8 mois avant la mise en ligne initiale de l'article sur ArXiV). Il est probable qu'une partie des concepts abordés aient été revus dans la version finale du papier. Toutefois, les concepts abordés et résultats obtenus lors de ce stage restent pertinents vis à vis de l'article final.
]
