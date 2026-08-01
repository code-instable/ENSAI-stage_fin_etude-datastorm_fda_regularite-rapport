// Typst port of src/rapport.tex — entry point.
#import "lib/theme.typ": page-setup, heading-style
#import "lib/vars.typ": articletitle, auteur
#import "content/pre/cover.typ": cover
#import "content/pre/abstract.typ": abstract
#import "content/pre/notations.typ": notations

#set document(title: articletitle, author: auteur)
#show: page-setup
#show: heading-style

// ~ PRE CONTENT — no page numbering (src/content/pre/main.tex)
#set page(numbering: none)
#counter(page).update(1)
#cover()
#pagebreak()
#abstract()
#pagebreak()
#notations()
#pagebreak()

// ~ Table of Contents / List of Figures / List of Algorithms — roman numbering
#set page(numbering: "I")
#counter(page).update(1)

#outline(title: [Table des matières], indent: auto)
#pagebreak()
#outline(title: [Table des figures], target: figure.where(kind: image))
#pagebreak()
// English title, unaltered: algorithm2e's `\listofalgorithms` was never
// localized to French in the LaTeX source (see out/rapport.pdf, "List of
// Algorithms"), unlike \listoffigures/\tableofcontents which babel-french
// does localize.
#outline(title: [List of Algorithms], target: figure.where(kind: "algorithm"))
#pagebreak()

// ~ CONTENT — arabic numbering (src/rapport.tex chapters 1-4)
#set page(numbering: "1")
#counter(page).update(1)

#include "content/chapter1.typ"
#include "content/chapter2/main.typ"
#include "content/chapter3/main.typ"
#include "content/chapter4/main.typ"

// ~ APPENDIX — roman numbering (src/rapport.tex \appendix + \pagenumbering{roman})
#set page(numbering: "i")
#counter(page).update(1)
#counter(heading).update(0)
#set heading(numbering: (..nums) => {
  let n = nums.pos()
  if n.len() == 1 { numbering("A", n.at(0)) } else { numbering("A.1.1.1", ..n) }
})

#include "content/appendix.typ"

#bibliography(
  "bibliography.yml",
  title: [Bibliographie],
  style: "association-for-computing-machinery",
  full: true,
)
