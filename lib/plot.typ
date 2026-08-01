// Function plots and diagrams built on CeTZ, replacing the PGFPlots/TikZ
// figures of src/include/definition/pgfplot.tex and the `tikzpicture`
// environments scattered across content/chapter_1, content/chapter_2 and
// content/chapter_3. `cetz-plot` (the natural PGFPlots counterpart) could not
// be used: its only published release (0.1.1) internally pins `cetz 0.3.2`,
// whose `canvas` rendering relies on Typst's legacy `path()` primitive in a
// way that raises "expected path or string, found array" under Typst 0.15.1
// (confirmed by direct compilation). This module is therefore a small local
// abstraction built directly on CeTZ 0.5.0's stable low-level `draw` API
// (line/content/circle/bezier), which compiles cleanly under 0.15.1.

#import "@preview/cetz:0.5.0"

// Riemann-type non-differentiable function used throughout ch.1/2 figures:
// W(x) = sum_{k=1}^{n} sin(pi k^a x) / (pi k^a), the same partial sum
// computed by the \weierstrass PGF macro in
// src/include/definition/pgfplot.tex (its \pgfmathsin/\pgfmathdeg round-trip
// is a no-op: sin(deg(pi k^a x)) taken in degrees equals sin(pi k^a x) in
// radians).
#let weierstrass(x, a, n) = {
  range(1, n + 1).map(k => calc.sin(calc.pi * calc.pow(k, a) * x) / (calc.pi * calc.pow(k, a))).sum()
}

// Maps a data-space point to drawing-space coordinates (in cm) given axis ranges and a target size.
#let _map-point(pt, x-range, y-range, w, h) = (
  (pt.at(0) - x-range.at(0)) / (x-range.at(1) - x-range.at(0)) * w,
  (pt.at(1) - y-range.at(0)) / (y-range.at(1) - y-range.at(0)) * h,
)

// A single 2D axes plot in the visual style of the original PGFPlots figures:
// centered axis lines with arrowheads, no ticks by default, optional sampled
// curves, point markers, dashed reference lines, floating labels and legend.
#let plot-2d(
  size: (8, 5),
  x-range: (0, 1),
  y-range: (-1, 1),
  x-ticks: none,
  y-ticks: none,
  curves: (),
  markers: (),
  vlines: (),
  labels: (),
  brackets: (),
  legend: none,
) = {
  let (w, h) = size
  let map(pt) = _map-point(pt, x-range, y-range, w, h)
  cetz.canvas(length: 1cm, {
    import cetz.draw: *

    // ~ axis lines through the origin (or through the domain edge, if 0 is
    // outside the range), matching `axis lines=middle` / `axis lines=center`.
    let x0 = map((calc.max(x-range.at(0), calc.min(x-range.at(1), 0)), 0)).at(0)
    let y0 = map((0, calc.max(y-range.at(0), calc.min(y-range.at(1), 0)))).at(1)
    line((0, y0), (w, y0), mark: (end: "stealth"), stroke: 0.5pt)
    line((x0, 0), (x0, h), mark: (end: "stealth"), stroke: 0.5pt)

    if x-ticks != none {
      for (x, lbl) in x-ticks {
        let p = map((x, 0))
        line((p.at(0), y0 - 0.06), (p.at(0), y0 + 0.06), stroke: 0.5pt)
        content((p.at(0), y0 - 0.28), text(size: 8pt, lbl))
      }
    }
    if y-ticks != none {
      for (y, lbl) in y-ticks {
        let p = map((0, y))
        line((x0 - 0.06, p.at(1)), (x0 + 0.06, p.at(1)), stroke: 0.5pt)
        content((x0 - 0.35, p.at(1)), text(size: 8pt, lbl))
      }
    }

    // ~ sampled function curves (\addplot)
    for c in curves {
      let n = c.at("samples", default: 200)
      let (lo, hi) = c.domain
      let pts = range(n + 1).map(i => {
        let x = lo + (hi - lo) * i / n
        map((x, (c.fn)(x)))
      })
      line(..pts, stroke: c.at("stroke", default: 1pt) + c.at("color", default: black))
    }

    // ~ dashed vertical reference lines
    for vl in vlines {
      let p = map((vl.x, y-range.at(0)))
      let q = map((vl.x, y-range.at(1)))
      line((p.at(0), 0), (p.at(0), h), stroke: (paint: vl.at("color", default: black), thickness: 0.6pt, dash: "dashed"))
    }

    // ~ point markers (\addplot ... only marks)
    for m in markers {
      let p = map((m.x, m.y))
      circle(p, radius: 0.045, fill: m.at("color", default: black), stroke: none)
    }

    // ~ floating text labels, with an opaque backdrop to imitate the
    // white-fill rectangles PGFPlots uses to erase the axis/curve behind a label
    for lb in labels {
      let p = map(lb.at)
      content(p, box(fill: white, inset: 1pt, text(size: 9pt, fill: lb.at("color", default: black), lb.body)))
    }

    // ~ double-headed "<->" bracket annotating a Δ-sized span, with a
    // centered label straddling the arrow (the recurring PGF idiom used
    // throughout ch.2/ch.3 to point out a J_Delta interval)
    for br in brackets {
      let color = br.at("color", default: black)
      let p = map((br.from, 0))
      let q = map((br.to, 0))
      let yy = p.at(1) + br.y
      line((p.at(0), yy), (q.at(0), yy), mark: (start: "stealth", end: "stealth"), stroke: 0.5pt + color)
      content(((p.at(0) + q.at(0)) / 2, yy), box(fill: white, inset: 1pt, text(size: 9pt, fill: color, br.label)))
    }

    // ~ legend, stacked underneath the plot; label text wraps within the
    // plot's own width instead of overflowing past it (long labels are
    // common here, e.g. "Points d'estimation de la régularité locale")
    if legend != none {
      let ly = -0.5
      for (i, entry) in legend.enumerate() {
        let yy = ly - i * 0.9
        line((0.1, yy), (0.6, yy), stroke: 1.2pt + entry.color)
        content(
          (0.8, yy), anchor: "west",
          box(width: (w - 0.8) * 1cm, text(size: 8pt, entry.label)),
        )
      }
    }
  })
}

// Simple 3D wireframe surface plot, replacing `\addplot3[surf]`
// (content/chapter_3/simulation-parametres/noyau-far.tex). CeTZ's `draw`
// primitives natively accept 3-tuple (x, y, z) coordinates and project them,
// which is enough to draw a wireframe mesh without needing `cetz-plot`'s
// (unavailable) contour/surface routines.
#let wireframe3d(fn, x-range: (0, 1), y-range: (0, 1), z-range: (0, 1), divisions: 12, size: 6) = {
  cetz.canvas(length: 1cm, {
    import cetz.draw: *
    ortho(x: 65deg, y: 0deg, z: -45deg, {
      let (x0, x1) = x-range
      let (y0, y1) = y-range
      let (z0, z1) = z-range
      let sx(x) = (x - x0) / (x1 - x0) * size
      let sy(y) = (y - y0) / (y1 - y0) * size
      let sz(z) = (z - z0) / (z1 - z0) * size
      let pt(x, y) = (sx(x), sy(y), sz(calc.min(z1, calc.max(z0, fn(x, y)))))

      for i in range(divisions + 1) {
        let x = x0 + (x1 - x0) * i / divisions
        line(..range(divisions + 1).map(j => pt(x, y0 + (y1 - y0) * j / divisions)), stroke: 0.35pt + gray)
      }
      for j in range(divisions + 1) {
        let y = y0 + (y1 - y0) * j / divisions
        line(..range(divisions + 1).map(i => pt(x0 + (x1 - x0) * i / divisions, y)), stroke: 0.35pt + gray)
      }
      line((0, 0, 0), (size + 0.4, 0, 0), mark: (end: "stealth"), stroke: 0.5pt)
      content((size + 0.6, 0, 0), $t$)
      line((0, 0, 0), (0, size + 0.4, 0), mark: (end: "stealth"), stroke: 0.5pt)
      content((0, size + 0.6, 0), $s$)
      line((0, 0, 0), (0, 0, size + 0.4), mark: (end: "stealth"), stroke: 0.5pt)
      content((0, 0, size + 0.6), $beta$)
    })
  })
}

// Four-corner commutative-diagram helper for the "découpage du contrôle des
// erreurs" schemas (content/appendix/theorie/estimation_adaptative/estimation_adaptative__moyenne.tex):
// top-left --right--> top-right --down--> bottom-right
// bottom-left --up--> top-left            (bottom-right left standalone)
// An optional `diagonal-label` draws a fourth, sloped top-left --> bottom-right
// arrow (the MPV variant's `\arrow[dr, ..., sloped]`).
#let error-decomposition-diagram(
  top-left, top-right, bottom-left, bottom-right,
  right-label, down-label, up-label,
  right-color: black, down-color: black, up-color: black,
  diagonal-label: none, diagonal-color: black,
) = cetz.canvas(length: 1cm, {
  import cetz.draw: *
  let tl = (0, 3)
  let tr = (9, 3)
  let bl = (0, 0)
  let br = (9, 0)
  content(tl, top-left, anchor: "center", padding: 0.1)
  content(tr, top-right, anchor: "center", padding: 0.1)
  content(bl, bottom-left, anchor: "center", padding: 0.1)
  content(br, bottom-right, anchor: "center", padding: 0.1)
  line((1.1, 3), (7.9, 3), mark: (end: "stealth"), stroke: 0.5pt + right-color)
  content((4.5, 3.3), text(size: 8pt, fill: right-color, right-label))
  line((9, 2.6), (9, 0.4), mark: (end: "stealth"), stroke: 0.5pt + down-color)
  content((9.9, 1.5), text(size: 8pt, fill: down-color, down-label))
  line((0, 0.4), (0, 2.6), mark: (end: "stealth"), stroke: 0.5pt + up-color)
  content((-1.1, 1.5), text(size: 8pt, fill: up-color, up-label))
  if diagonal-label != none {
    line((0.6, 2.6), (8.4, 0.4), mark: (end: "stealth"), stroke: 0.5pt + diagonal-color)
    content(
      (4.5, 1.2),
      angle: -18.43deg,
      text(size: 8pt, fill: diagonal-color, diagonal-label),
    )
  }
})
