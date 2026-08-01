// Central theme: palette, page geometry, typography, heading styles.
// Mirrors src/include/definition/custom_colors.tex, src/include/packages/fonts.tex,
// src/include/packages/base.tex (geometry) and src/include/settings/styling.tex.

// ~ Flat UI color palette (src/include/definition/custom_colors.tex)
#let flat = (
  blue: rgb("#2980b9"),
  green: rgb("#16a085"),
  greenish: rgb("#10ac84"),
  purple: rgb("#574b90"),
  purple-light: rgb("#786fa6"),
  purple-dark: rgb("#2c2c54"),
  rose: rgb("#c44569"),
  orange-light: rgb("#f19066"),
  red-light: rgb("#e66767"),
  biscay: rgb("#303952"),
  corn-flower: rgb("#546de5"),
  imperial: rgb("#222f3e"),
  aqua: rgb("#01a3a4"),
  blue-light: rgb("#0abde3"),
  blue-deep: rgb("#54a0ff"),
  blue-devil: rgb("#227093"),
  magenta: rgb("#f368e0"),
  orange: rgb("#ff9f43"),
  yellow: rgb("#ffb142"),
  tomato: rgb("#eb2f06"),
  light-gray: rgb("#bdc3c7"),
)

// hyperref defaults (colorlinks = false): bordered link annotations.
// linkcolor = red, citecolor = green, urlcolor = cyan.
#let link-colors = (
  link: rgb("#ff0000"),
  cite: rgb("#00ff00"),
  url: rgb("#00ffff"),
)

// ~ Fonts (src/include/packages/fonts.tex : \sffamily default, Noto Serif / Noto
// Sans / JetBrainsMonoNerdFont / XITS Math under lualatex). XITS Math is
// substituted with STIX Math (its OFL-licensed sibling family) and
// JetBrainsMonoNerdFont with the plain JetBrains Mono, since the Nerd Font glyph
// patches are not otherwise used in the document body.
#let fonts = (
  sans: "Noto Sans",
  serif: "Noto Serif",
  mono: "JetBrains Mono",
  math: "STIX Math",
)

// ~ Chapter-scoped numbering ("Figure 1.1", "Table 2.1", tag "(3.2)" for the
// rare numbered equation), reset at each chapter (level-1 heading); flat
// numbering for algorithms ("Algorithm 1" — the English word literally as
// rendered by the un-localized algorithm2e package in the LaTeX source, see
// `out/rapport.pdf`'s own "List of Algorithms"). Every cross-reference in
// the source is a bare `\ref{}` (never `\eqref`/`\autoref`/`\Cref`): the
// author always supplies the describing word themselves in prose (e.g. "la
// figure \ref{...}"), so `@label` must display a bare number, while a
// figure/table/equation's own in-place tag keeps its "Figure"/"Table"/"(…)"
// decoration.
//
// figure()'s and math.equation()'s built-in `numbering:` closures are
// invoked in a `context` anchored to wherever their *output* is finally
// displayed — correct for an in-place caption/tag (rendered exactly where
// the figure/equation sits), but wrong for a later `@ref` or an
// `outline()` entry (both would show the chapter at their own position
// instead of the target's). Anywhere that could happen, the number is
// instead recomputed from an explicit target location via `.at(loc)`.
//
// Typst's default heading reference prepends an auto-localized supplement
// ("Chapitre", regardless of level) that the source never had: `\ref{}` is
// always bare in the LaTeX (see the file-level note below), so a section
// cross-reference must show only the number, e.g. "2.2.3". Main-matter and
// appendix headings use different `numbering:` values (a string pattern vs.
// a function, see main.typ), so both are handled here.
#let heading-ref-number(e) = context {
  let n = counter(heading).at(e.location())
  if type(e.numbering) == function { (e.numbering)(..n) } else { numbering(e.numbering, ..n) }
}

// Same idea, but formats only the first `levels` numbers of `e`'s position
// (e.g. the level-1..3 "A.1.1" prefix in front of a level-4 subsubsection's
// own "□ A⟩" letter) — needed because the appendix's chapter number is a
// letter produced by a numbering *function*, not a plain digit `str()` can
// reproduce (see `chapter-of` below for the same issue at chapter level).
#let heading-prefix-number(e, levels) = context {
  let n = counter(heading).at(e.location()).slice(0, levels)
  if type(e.numbering) == function { (e.numbering)(..n) } else { numbering(e.numbering, ..n) }
}

// The chapter part of "Figure 2.1" / "(3.2)": *not* simply
// `counter(heading).at(loc).first()`, because in the appendix that raw
// integer isn't what's actually displayed — chapters there are lettered
// ("A", "B", …) by a custom numbering function (see main.typ). Finding the
// nearest level-1 heading and formatting it the same way the heading
// itself is formatted keeps the two consistent.
#let chapter-of(loc) = {
  let hs = query(selector(heading.where(level: 1)).before(loc))
  if hs.len() == 0 { [0] } else { heading-ref-number(hs.last()) }
}
#let chapter-fig-number(loc, kind) = (chapter-of(loc), counter(figure.where(kind: kind)).at(loc).first())

// A `\begin{figure}` whose `\caption{}` call is commented out in the source
// never allocates a number (that's what LaTeX's `\caption` does) and prints
// no caption line — just the bare content. `caption: none` reproduces that.
#let _figure-caption-block(it) = if it.caption == none {
  align(center, it.body)
} else {
  context {
    let (chapter-n, fig-n) = chapter-fig-number(it.location(), it.kind)
    block(breakable: true, width: 100%, {
      align(center, it.body)
      v(0.65em)
      align(center, [#it.supplement~#chapter-n.#fig-n #sym.dash.en #h(0.3em) #it.caption.body])
    })
  }
}

// equations are numbered only via `#numeq(...)`; everything else (the vast
// majority) is left as a plain unnumbered `$ ... $` block, matching the
// source's near-universal use of `equation*`/bare `\[...\]`. Built directly
// (not via `numbering("(1.1)", ...)`) since `chapter-of` returns already-
// formatted content (a plain digit in the main matter, a letter in the
// appendix), not the integer that pattern-based `numbering()` requires.
#let numeq = n => context [(#chapter-of(here()).#n)]


#let page-setup(body) = {
  set page(
    paper: "us-letter",
    margin: (top: 1.5cm, bottom: 1.5cm, x: 2cm),
    numbering: "1",
  )
  set text(font: fonts.sans, size: 11pt, lang: "fr")
  // LaTeX default: justified, indented paragraphs (except right after a
  // heading), no extra gap between paragraphs beyond normal leading.
  set par(justify: true, first-line-indent: (amount: 1.5em, all: false), spacing: 0.65em)
  set math.equation(numbering: none)
  show math.equation: set text(font: fonts.math)
  show raw: set text(font: fonts.mono)

  show figure.where(kind: image): _figure-caption-block
  show figure.where(kind: table): _figure-caption-block
  show figure.where(kind: "algorithm"): set figure.caption(separator: [ : ])

  show outline.entry: it => {
    let e = it.element
    if e != none and e.func() == figure and e.kind in (image, table) {
      context {
        let (chapter-n, fig-n) = chapter-fig-number(e.location(), e.kind)
        block(width: 100%, link(e.location(), [
          #e.supplement~#chapter-n.#fig-n #h(0.5em) #e.caption.body
          #box(width: 1fr, it.fill) #it.page()
        ]))
      }
    } else {
      it
    }
  }

  // hyperref-style bordered links instead of colored text.
  show link: it => {
    if type(it.dest) == str {
      box(stroke: 0.6pt + link-colors.url, outset: 1pt, it)
    } else {
      it
    }
  }
  show ref: it => {
    let e = it.element
    box(stroke: 0.6pt + link-colors.link, outset: 1pt, {
      if e != none and e.func() == figure and e.kind in (image, table) {
        context {
          let (chapter-n, fig-n) = chapter-fig-number(e.location(), e.kind)
          link(e.location(), [#chapter-n.#fig-n])
        }
      } else if e != none and e.func() == math.equation {
        context {
          let loc = e.location()
          let chapter-n = chapter-of(loc)
          let eq-n = counter(math.equation).at(loc).first()
          link(loc, [#chapter-n.#eq-n])
        }
      } else if e != none and e.func() == heading {
        link(e.location(), heading-ref-number(e))
      } else if e != none and e.func() == metadata {
        link(e.location(), [#e.value])
      } else {
        it
      }
    })
  }
  show cite: it => box(stroke: 0.6pt + link-colors.cite, outset: 1pt, it)

  body
}

// ~ Sectioning counters used by the custom subsubsection numbering scheme
// (\renewcommand{\thesubsubsection}{\thesubsection \quad □ \Alph{subsubsection}⟩})
#let subsubsection-counter = counter("subsubsection-in-subsection")

#let heading-style(body) = {
  set heading(numbering: "1.1.1.1")

  // The show rules below re-emit each heading's body as plain inline
  // content (for the "Chapitre N" line, custom subsubsection lettering,
  // etc.), which — unlike a native heading — is otherwise still subject to
  // the global `first-line-indent` (see page-setup): without this, a
  // heading spanning two lines gets its first line indented like a body
  // paragraph.
  show heading: set par(first-line-indent: 0pt)

  show heading.where(level: 1): it => {
    subsubsection-counter.update(0)
    // Chapter-scoped figure/table/equation numbering (see theme.typ's
    // `_figure-caption-block`/`numeq`) resets here. This must live in
    // *this* show rule rather than a separate one on the same selector:
    // this rule fully replaces the heading's content instead of yielding
    // back to `it`, so a same-selector rule registered earlier (e.g. in
    // page-setup) never actually runs.
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(math.equation).update(0)
    pagebreak(weak: true)
    v(2.5em)
    if it.numbering != none {
      text(size: 13pt, weight: "regular")[Chapitre #counter(heading).display()]
      v(0.3em)
    }
    text(size: 24pt, weight: "bold", it.body)
    v(1.5em)
  }

  show heading.where(level: 2): it => {
    subsubsection-counter.update(0)
    v(1.4em, weak: true)
    text(size: 16pt, weight: "bold")[#counter(heading).display() #h(0.5em) #it.body]
    v(0.6em, weak: true)
  }

  show heading.where(level: 3): it => {
    subsubsection-counter.update(0)
    v(1.1em, weak: true)
    text(size: 13pt, weight: "bold")[#counter(heading).display() #h(0.5em) #it.body]
    v(0.5em, weak: true)
  }

  // subsubsection: "⟨parent section.subsection⟩ □ ⟨A,B,C…⟩⟩ Title"
  show heading.where(level: 4): it => context {
    v(1em, weak: true)
    let parent-numbering = heading-prefix-number(it, 3)
    let n = subsubsection-counter.at(it.location()).first() + 1
    subsubsection-counter.update(n)
    let letter = numbering("A", n)
    text(size: 11pt, weight: "bold")[
      #parent-numbering #h(0.4em) #sym.square.stroked #h(0.3em) #letter⟩
      #h(0.5em) #it.body
    ]
    v(0.4em, weak: true)
  }

  body
}
