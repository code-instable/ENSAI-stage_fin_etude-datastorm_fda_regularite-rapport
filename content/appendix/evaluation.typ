// ~ src/content/appendix/chap_histoire.tex is not involved — this ports the
// \includepdf[pages=-]{...} calls at the end of src/content/appendix/main.tex.
//
// The LaTeX source \includepdf's three scans: "BRUNET jury.pdf", BRUNET-1.pdf
// and Brunet.pdf. Only two of those three actually appear in out/rapport.pdf
// (91 pages total: two evaluation-form pages immediately followed by the
// bibliography) — "BRUNET jury.pdf" (the one filename containing a space)
// never made it into the rendered reference output, most likely because that
// space broke \includepdf's path handling during the author's own build.
// Reproducing the rendered document exactly (not the source's unrealized
// intent) means embedding only BRUNET-1.pdf and Brunet.pdf, in that order.
#set page(margin: 0pt)
#align(center + horizon, image("/src/content/evaluation/BRUNET-1.pdf", width: 100%, height: 100%, fit: "contain"))
#pagebreak(weak: true)
#align(center + horizon, image("/src/content/evaluation/Brunet.pdf", width: 100%, height: 100%, fit: "contain"))
#pagebreak(weak: true)
#set page(margin: (top: 1.5cm, bottom: 1.5cm, x: 2cm))
