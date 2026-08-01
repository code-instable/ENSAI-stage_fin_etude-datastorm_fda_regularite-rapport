// Custom math notation, ported from src/include/commands/maths/*.tex and
// src/include/definition/{define,pgfplot}.tex. Each LaTeX \newcommand has a
// same-purpose Typst function here; native Typst styling (bb, cal, frak, sans,
// upright) replaces the bare \mathds/\mathcal/\mathfrak/\mathsf wrappers, which
// are used ad-hoc directly at call sites rather than through a wrapper macro.
//
// IMPORTANT Typst quirk: inside a `$...$` template, a bare identifier is
// *always* rendered as a literal math symbol/variable, never as a lookup of
// an enclosing Typst variable — even a function's own parameter. Substituting
// an actual argument requires an explicit `#name` (exactly as in markup
// mode). Every parameter reference below is therefore written as `#name`,
// including when passed on to a nested call.

// ~ src/include/commands/maths/ensembles.tex
#let intervaleint(a, b) = $lr(⟦ #a #h(0.2em) , #h(0.2em) #b ⟧)$
#let RR(p) = $bb(R)^(#p)$
#let classespace(k, E) = $cal(C)^(#k) (#E)$
#let continuborne(E, F) = $cal(C)^0_b (#E , #F)$
#let continusupportcompact(E, F) = $cal(C)^0_K (#E , #F)$
#let mesurable(E, F) = $upright(m) (#E , #F)$
#let etageepositive(E, F) = $cal(E)_+ (#E , #F)$
#let VA(E) = $bb(V) A [ #E ]$
#let matrixspace(n, E) = $cal(M)_(#n) (#E)$
#let orthonormal = $limits(perp)_(bar.v.double dot.op bar.v.double)$
#let orthonormalselon(p) = $limits(perp)_(bar.v.double dot.op bar.v.double_(#p))$
#let Rplus = $bb(R)_+$
#let Rmoins = $bb(R)_-$
#let Rplusetoile = $bb(R)_+^*$
#let Rmoinsetoile = $bb(R)_-^*$
#let Retoile = $bb(R)^*$

// ~ src/include/commands/maths/proba.tex, proba_lettres.tex
#let indep = $perp #h(-3pt) perp$
#let samelaw = $limits(tilde)^cal(L)$
#let proba(e) = $bb(P) [ #e ]$
#let probaloi(l, e) = $bb(P)_(#l) [ #e ]$
#let variance(x) = $bb(V) [ #x ]$
#let esperance(x) = $bb(E) [ #x ]$
#let esperanceloi(l, x) = $bb(E)_(#l) [ #x ]$
#let esperancesachant(x, y) = $bb(E) [ #y bar.v #x ]$
#let esploisach(p, x, y) = $bb(E)_(#p) [ #y bar.v #x ]$
#let va(e) = $op("VA")[ #e ]$

// ~ src/include/commands/maths/fonctions_et_operateurs.tex
#let indicatrice(e) = $bb(1)_(#e)$
#let norme(p, x) = $lr(bar.v.double #x bar.v.double)_(#p)$
#let dist(x, y) = $lr(bar.v.double #x - #y bar.v.double)$
#let distnorme(p, x, y) = $lr(bar.v.double #x - #y bar.v.double)_(#p)$
#let prodscal(x, y) = $lr(⟨ #x mid(bar.v) #y ⟩)$
#let prodscalselon(x, y, p) = $lr(⟨ #x mid(bar.v) #y ⟩)_(#p)$
#let argmax = math.op("argmax", limits: true)
#let argmin = math.op("argmin", limits: true)
#let inverse(a) = $#a ^(-1)$
#let isdef = $limits(equiv)_"déf"$
#let comm(a) = $op("Comm") (#a)$
#let rg(a) = $op("rg") (#a)$
#let im = math.op("Im")
#let pgcd(a, b) = $op("pgcd") (#a , #b)$
#let positive(x) = $[ #x ]_+$
#let func(dom, codom, x, y) = $#dom limits(->) #codom \ #x limits(|->) #y$
#let opnorm(t) = $lr(bar.v.triple #t bar.v.triple)$
#let Sp(u, field: none) = if field == none { $op("sp") (#u)$ } else { $op("sp")_(#field) (#u)$ }
#let spvec(u, field: none) = if field == none { $arrow(op("sp")) (#u)$ } else { $arrow(op("sp"))_(#field) (#u)$ }
#let spvecortho(u, field: none, norm: none) = {
  let base = if field == none { $arrow(op("sp"))$ } else { $arrow(op("sp"))_(#field)$ }
  let perpsym = if norm == none { $limits(perp)_(bar.v.double dot.op bar.v.double)$ } else { $limits(perp)_(bar.v.double dot.op bar.v.double_(#norm))$ }
  $#base [ #perpsym ] (#u)$
}

// ~ src/include/commands/maths/convergence.tex
#let cv-arrow(top, bottom) = math.attach(math.arrow.r.long, t: top, b: bottom)
#let cvl(n, target) = cv-arrow($cal(L)$, $#n arrow.r #target$)
#let cvp(n, target) = cv-arrow($bb(P)$, $#n arrow.r #target$)
#let cvps(n, target) = cv-arrow(math.sans("p.s"), $#n arrow.r #target$)
#let cvL(p, n, target) = cv-arrow($bb(L)^(#p)$, $#n arrow.r #target$)
#let cvetr(n, target) = cv-arrow(math.sans("étroit."), $#n arrow.r #target$)
#let cvnorme(p, n, target) = cv-arrow($lr(bar.v.double dot.op bar.v.double)_(#p)$, $#n arrow.r #target$)
#let cvpp(measure, n, target) = cv-arrow($#measure upright("-p.p")$, $#n arrow.r #target$)
#let tend(n, target) = cv-arrow($$, $#n arrow.r #target$)
#let tendset(n, target, upperset) = cv-arrow($#upperset$, $#n arrow.r #target$)

// ~ src/include/commands/maths/integral.tex
#let custint(symbol) = $limits(integral)^upright(#symbol)$
#let leb = $custint(cal(L))$
#let lebm(a, f, x) = $custint(cal(L))_(#a) #h(0.2em) #f med d #x$
#let lebesgue(a) = $custint(cal(L))_(#a)$
#let lebint(a, b) = $custint(cal(L))_(#a)^(#b)$
#let dun = $custint(bb(D))$
#let dunm(a, f, x) = $custint(bb(D))_(#a) #h(0.2em) #f med d #x$
#let dunford(a) = $custint(bb(D))_(#a)$
#let dunint(a, b) = $custint(bb(D))_(#a)^(#b)$
#let boch = $custint(bb(B))$
#let bochm(a, f, x) = $custint(bb(B))_(#a) #h(0.2em) #f med d #x$
#let bochner(a) = $custint(bb(B))_(#a)$
#let bochint(a, b) = $custint(bb(B))_(#a)^(#b)$
#let riem = $custint(cal(R))$
#let riemm(a, f, x) = $custint(cal(R))_(#a) #h(0.2em) #f med d #x$
#let riemann(a) = $custint(cal(R))_(#a)$
#let riemint(a, b) = $custint(cal(R))_(#a)^(#b)$
#let pet = $custint(cal(P))$
#let petm(a, f, x) = $custint(cal(P))_(#a) #h(0.2em) #f med d #x$
#let pettis(a) = $custint(cal(P))_(#a)$
#let petint(a, b) = $custint(cal(P))_(#a)^(#b)$

// ~ src/include/commands/maths/limites.tex (stochastic Landau notation).
// Only the unstarred form is used in the report: the starred variant was
// noted by the author as broken ("la version * ne marche pas") and unused.
#let petitop(x) = $o_P (#x)$
#let grandop(x) = $O_P (#x)$

// ~ src/include/commands/maths/suites.tex
#let statrang(x, n, k) = $(#x)_(#n)^((#k))$
#let suiteensemble(e) = $(#e)^bb(N)$
#let suite(x, n) = $(#x _#n)_(#n gt.eq 0)$
#let soussuite(x, n) = $(#x _(n_#n))_(#n gt.eq 0)$
#let famille(x, i) = $(#x _#i)_(#i in I)$
#let suitecomposition(f, x, n) = $(#f (#x _#n))_(#n gt.eq 0)$
#let suitestatrang(x, n, i) = $(statrang(#x, #i, "i"))_(#n , #i)$
#let famfinie(x, a, b, i: $i$) = $(#x _#i)_(#a , #b)$
#let fromto(x, a, b) = $#x _(#a med : med #b)$
#let ordered(x, k) = $#x _((#k))$

// ~ src/include/commands/maths/topologie.tex (only \orthonormal is actually
// used in the report; \vois/\voisselon/\voisnorm are ported for completeness)
#let vois(x0) = $cal(V) (#x0)$
#let voisselon(topo, x0) = $cal(V)_(#topo) (#x0)$
#let voisnorm(p, x0) = $cal(V)_(bar.v.double dot.op bar.v.double_(#p)) (#x0)$

// ~ src/include/definition/define.tex, document_commands.tex
#let rddots = $dots.up$
#let petito(x) = $cal(o) (#x)$
#let grando(x) = $cal(O) (#x)$
#let cindexA = $limits(dot.op)_(1 arrow.r 3)^(1 arrow.r 2)$
#let cindexB = $limits(dot.op)_(1 arrow.r 3)^(2 arrow.r 3)$
#let cindexC = $limits(dot.op)_(1 arrow.r 2)^(2 arrow.r 3)$
#let thetaA = $Theta cindexA$
#let thetaB = $Theta cindexB$
#let thetaC = $Theta cindexC$
