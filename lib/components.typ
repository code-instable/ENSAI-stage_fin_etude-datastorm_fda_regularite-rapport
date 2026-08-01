// Callout boxes, colored text and small decorative helpers, ported from
// src/include/commands/graphics/{awesomebox,colorize,circled,blackbox}.tex and
// src/include/commands/editor/__main__.tex.
//
// FontAwesome glyphs (\faInfoCircle, \faExclamationTriangle, ...) are replaced
// with monochrome Unicode symbols that inherit the callout color, since the
// FontAwesome6 codepoints used by Typst's `fontawesome` package require
// desktop font assets that are not reliably available in the build
// environment; a few purely decorative icons (brain, lightbulb, book, jet,
// flask) fall back to color emoji via Noto Color Emoji. Semantic
// color-coding and placement are preserved exactly.

#import "theme.typ": flat

// ~ src/include/commands/graphics/awesomebox.tex
// \awesomebox[linecolor]{linewidth}{icon}{iconcolor}{text}
#let awesomebox(color, icon, body) = block(
  breakable: true,
  above: 0.8em,
  below: 0.8em,
  grid(
    columns: (2.2em, 1fr),
    column-gutter: 0.6em,
    align(center + top, text(size: 1.5em, fill: color, icon)),
    block(
      inset: (left: 0.6em),
      stroke: (left: 2pt + color),
      breakable: true,
      body,
    ),
  ),
)

#let info(body) = awesomebox(flat.blue, "ℹ", body)
#let chk(body) = awesomebox(flat.green, "✓", body)
#let brain(body) = awesomebox(flat.purple-light, "🧠", body)
#let warn(body) = awesomebox(flat.orange-light, "⚠", body)
#let nope(body) = awesomebox(flat.red-light, "✗", body)
#let cogs(body) = awesomebox(flat.imperial, "⚙", body)
#let citer(body) = awesomebox(flat.corn-flower, "❞", body)
#let avion(body) = awesomebox(flat.purple-dark, "✈", body)
#let flask(body) = awesomebox(flat.blue-devil, "🧪", body)
#let idee(body) = awesomebox(flat.yellow, "💡", body)
#let book(body) = awesomebox(flat.orange-light, "📖", body)
#let question(body) = awesomebox(flat.aqua, "?", body)

// ~ plain \fbox{\parbox{\textwidth}{...}} callout (no icon/color, just a
// bordered box spanning the text width)
#let fbox(body) = box(stroke: 0.5pt + black, inset: 1em, width: 100%, body)

// ~ src/include/commands/graphics/colorize.tex
#let colorize(body, color: flat.blue) = text(fill: color, body)
#let emphcolor(body, color: flat.blue) = text(fill: color, weight: "bold", body)

// ~ LaTeX \boxed{...}: a thin rule framing a (usually math) expression,
// distinct from the colored/filled `colorboxed` family below.
#let mathbox(body) = box(stroke: 0.5pt + black, outset: 5pt, body)

// ~ src/include/commands/graphics/blackbox.tex (only the plain variants and
// \blackboxed / \blueboxed / \orangeboxed are actually used in the report)
#let colorboxed(body, color: black) = box(
  fill: color, inset: (x: 0.4em, y: 0.3em), text(fill: white, weight: "bold", body),
)
#let blackboxed(body) = colorboxed(body, color: black)
#let blueboxed(body) = colorboxed(body, color: flat.blue-devil)
#let orangeboxed(body) = colorboxed(body, color: flat.orange)

// ~ src/include/commands/graphics/circled.tex
#let circled(body) = box(
  stroke: 0.5pt + black,
  radius: 100%,
  inset: 2pt,
  align(center + horizon, text(body)),
)

// ~ src/include/commands/editor/__main__.tex (editorial annotations kept
// verbatim: they are part of the author's rendered report, not scaffolding)
#let citationrequise = text(fill: flat.orange)[✎ ( ⚠ citation requise 🗎 )]
#let exemplerequis = text(fill: flat.orange)[✎ ( exemple concret requis )]
#let editorwarn(body) = text(fill: flat.orange)[⚠ #h(0.2em) ( #body )]
#let editlater(body) = text(fill: flat.blue-deep)[✎ #h(0.2em) ( #body )]
#let edited = text(fill: flat.aqua)[✎]

// ~ src/include/commands/macro/macro.tex, document_commands.tex
#let trq = $triangle.stroked.r quad$
#let largeskip = v(3em, weak: true)
#let dash = box(width: 0.5cm, height: 0.02cm, fill: black, baseline: -1pt)
#let yesequiv = $limits(⟺)^sans("✓")$
#let notequiv = $limits(⟺)^sans("✗")$
