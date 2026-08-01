// ~ src/content/pre/couverture/{main,LOGO/main}.tex
#import "../../lib/vars.typ": *

#let cover() = page(numbering: none, margin: (top: 1.5cm, bottom: 1.5cm, x: 2cm))[
  #set align(center)
  #set text(size: 11pt)

  #smallcaps(text(size: 17pt, entitytitle))
  #v(5mm)
  #grid(
    columns: (1fr, 1fr),
    align(center)[#image("/src/Images/ensai_logo.png", width: 85%)],
    align(center)[#image("/src/Images/datastom_logo.png", width: 85%)],
  )
  #v(0.7cm)

  #smallcaps(text(size: 17pt, projecttitle))
  #v(0.5cm)
  #text(size: 14pt, projectdescription)
  #v(0.7cm)

  #line(length: 100%, stroke: 0.7mm + black)
  #v(0.4cm)
  #text(size: 22pt, weight: "bold", articletitle)
  #v(0.4cm)
  #line(length: 100%, stroke: 0.7mm + black)
  #v(1cm)

  version corrigée et augmentée

  #v(1fr)

  #align(right)[
    #set text(size: 14pt)
    *rédigé par* \
    #auteur \
    *Tuteur* \
    Hassan Maissoro
  ]

  #v(2em)

  #text(size: 12pt, customdate)
]
