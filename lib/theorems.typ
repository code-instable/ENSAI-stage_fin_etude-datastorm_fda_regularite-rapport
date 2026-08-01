// Theorem-like environments, ported from src/include/definition/theorem_styles.tex
// (amsthm). "thm", "prop" and "lem" intentionally share one running counter,
// exactly as `\newtheorem{prop}{Proposition}[thm]` / `\newtheorem{lem}{Lemme}[thm]`
// do in the LaTeX source (the optional argument names another *theorem*'s
// counter, not a sectional one, so Théorème/Proposition/Lemme are numbered as
// a single interleaved sequence). "cor", "exo" and "definition" each keep an
// independent counter, matching the LaTeX source exactly.

#import "theme.typ": heading-ref-number

#let thm-counter = counter("thm-shared")
#let cor-counter = counter("cor")
#let exo-counter = counter("exo")
#let definition-counter = counter("definition")

// Next value a counter will take once stepped (querying `.display()` right
// after `.step()` would otherwise still observe the pre-increment value,
// since the update only takes effect strictly after the point it was
// logged) — callers must still call `.step()` themselves to advance it.
#let next(c) = c.get().first() + 1

// A bare `\ref{}` to a *numbered* environment (definition/thm/prop/lem/
// cor/exo) shows that environment's own number; a bare `\ref{}` to a label
// sitting inside an *unnumbered* one (any starred amsthm variant, or `rem`
// — always unnumbered in the source, see below) falls back to LaTeX's
// default behaviour of showing the nearest enclosing sectioning counter
// instead (confirmed against out/rapport.pdf: `\ref{def*:fda}`, a label
// inside a `definition*`, renders as the enclosing subsection's "2.1.1").
// Every constructor below therefore takes an optional `key:` — a plain
// string used as the referenceable Typst label name — and stores the
// resolved text as `metadata` right next to it: a value resolved via
// `context` *here*, at the environment's own true position (like a figure
// caption), rather than one a generic `show ref` would have to re-derive
// at the referencing site's position (which — like the figure/heading
// numbering closures in theme.typ — is not anchored to the target and
// would silently produce the wrong number).
#let _anchor(key, resolve) = if key != none {
  context [#metadata(resolve()) #label(key)]
}
#let _section-number() = {
  let hs = query(selector(heading).before(here()))
  if hs.len() == 0 { [] } else { heading-ref-number(hs.last()) }
}

// Public counterpart of `_anchor`/`_section-number`, for a bare `\label{}`
// sitting in plain prose (not inside any theorem-like environment) — same
// LaTeX fallback: a bare `\ref{}` to it shows the nearest enclosing
// sectioning counter's number.
#let anchor(key) = _anchor(key, _section-number)

#let thm-box(kind-name, counter-value, body, name: none, style: "thm") = block(
  breakable: true,
  above: if style == "def" { 10pt } else { 15pt },
  below: if style == "def" { 10pt } else { 15pt },
  {
    let head = if counter-value == none {
      strong(kind-name)
    } else {
      strong([#kind-name #counter-value])
    }
    let title-line = if name != none {
      [#head #h(0.3em) (#name)]
    } else {
      head
    }
    if style == "thm" {
      title-line
      linebreak()
      body
    } else {
      [#title-line #h(0.5em) #body]
    }
  },
)

// ~ Définition (def_style: numbered, independent counter)
#let definition(body, name: none, key: none) = context {
  let n = next(definition-counter)
  definition-counter.step()
  thm-box("Définition", str(n), body, name: name, style: "def")
  _anchor(key, () => str(n))
}
#let definition-star(body, name: none, key: none) = {
  thm-box("Définition", none, body, name: name, style: "def")
  _anchor(key, _section-number)
}

// ~ Théorème / Proposition / Lemme (thm_style: numbered, shared counter)
#let thm(body, name: none, key: none) = context {
  let n = next(thm-counter)
  thm-counter.step()
  thm-box("Théorème", str(n), body, name: name, style: "thm")
  _anchor(key, () => str(n))
}
#let thm-star(body, name: none, key: none) = {
  thm-box("Théorème", none, body, name: name, style: "thm")
  _anchor(key, _section-number)
}

#let prop(body, name: none, key: none) = context {
  let n = next(thm-counter)
  thm-counter.step()
  thm-box("Proposition", str(n), body, name: name, style: "thm")
  _anchor(key, () => str(n))
}
#let prop-star(body, name: none, key: none) = {
  thm-box("Proposition", none, body, name: name, style: "thm")
  _anchor(key, _section-number)
}

#let lem(body, name: none, key: none) = context {
  let n = next(thm-counter)
  thm-counter.step()
  thm-box("Lemme", str(n), body, name: name, style: "thm")
  _anchor(key, () => str(n))
}
#let lem-star(body, name: none, key: none) = {
  thm-box("Lemme", none, body, name: name, style: "thm")
  _anchor(key, _section-number)
}

// ~ Corollaire (independent counter)
#let cor(body, name: none, key: none) = context {
  let n = next(cor-counter)
  cor-counter.step()
  thm-box("Corollaire", str(n), body, name: name, style: "thm")
  _anchor(key, () => str(n))
}
#let cor-star(body, name: none, key: none) = {
  thm-box("Corollaire", none, body, name: name, style: "thm")
  _anchor(key, _section-number)
}

// ~ Propriété (unnumbered only, as in the LaTeX source)
#let propriete-star(body, name: none, key: none) = {
  thm-box("Propriété", none, body, name: name, style: "thm")
  _anchor(key, _section-number)
}

// ~ Exercice (independent counter)
#let exo(body, name: none, key: none) = context {
  let n = next(exo-counter)
  exo-counter.step()
  thm-box("Exercice", str(n), body, name: name, style: "thm")
  _anchor(key, () => str(n))
}
#let exo-star(body, name: none, key: none) = {
  thm-box("Exercice", none, body, name: name, style: "thm")
  _anchor(key, _section-number)
}

// ~ Remarque (rem_style: unnumbered only, emphasised head, ":" punctuation)
#let rem(body, name: none, key: none) = {
  block(
    breakable: true,
    above: 5pt,
    below: 5pt,
    {
      let head = emph(if name != none { [Remarque (#name)] } else { [Remarque] })
      [#head : #h(0.5em) #body]
    },
  )
  _anchor(key, _section-number)
}

// ~ src/include/commands/maths/preuve.tex : left-bar proof blocks
#let leftbar(body) = block(
  breakable: true,
  stroke: (left: 1pt + black),
  inset: (left: 1em, top: 0.3em, bottom: 0.3em, right: 0.3em),
  body,
)

#let preuve(body) = leftbar[*Démonstration.* #body #h(1fr) ∎]

#let subproof(title, body, indent: 0.1) = grid(
  columns: (indent * 1fr, (1 - indent) * 1fr),
  [], leftbar[*[▷ #box(stroke: black, inset: 3pt)[#title]]* #linebreak() #body],
)
#let subproofsmall(title, body) = subproof(title, body, indent: 0.05)
#let subproofmedium(title, body) = subproof(title, body, indent: 0.1)
#let subproofbig(title, body) = subproof(title, body, indent: 0.2)
