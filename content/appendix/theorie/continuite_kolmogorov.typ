// ~ src/content/appendix/theorie/continuite_kolmogorov.tex
#import "../../../lib/math.typ": *
#import "../../../lib/components.typ": mathbox
#import "../../../lib/theorems.typ": thm

Le théorème de continuité de Kolmogorov nous permet de dériver la régularité d'un processus, au sens de la classe de Hölder, à partir de l'espérance de ses incréments.

#thm(name: [Continuité de Kolmogorov], key: "thm:kolmogorov_continuite")[
  _référence :_ #cite(<capasso2015introduction>, supplement: [thm : 2.197 | page : 145])

  #align(center, mathbox(
    $ #table(
      columns: (auto, 1fr),
      stroke: none, inset: (x: 0.6em, y: 0.5em),
      align: left,
      [→], [$X : quad func(Rplus times Omega, bb(R), (t,omega), X(t,omega) = x(t))$ sans(" séparable")],
      [→], [$exists r,c,epsilon.alt,delta in Rplus quad (forall h < delta)(forall t in Rplus) quad esperance(abs(X(t+h) - X(t))^r) lt.eq c dot.op h^(1+epsilon.alt)$],
    ) $
  ))

  #align(center)[$arrow.b.double$]

  #align(center, mathbox(
    $ bold([*]) quad X sans(" est continu en ") t in Rplus sans(" pour presque tout ") omega in Omega $
  ))

  #align(center)[ie : il existe une version $tilde(X)$ de $X$ continue en $t$ telle que $proba(tilde(X)(t) = X(t)) = 1$]

  #align(center, mathbox(
    $ bold([*]) quad tilde(X) sans(" est ") gamma sans("-Hölderienne en ") t sans(" pour tout ") 0 < gamma < epsilon.alt/r $
  ))
]

Étant donné que notre estimateur utilise les incréments quadratiques, on se place dans le cas où $r = 2$. Dans notre cas, $epsilon = 1$.

#v(1.5em)

C'est ce théorème qui est exploité pour récupérer la régularité locale de nos données en utilisant un estimateur de $esperance(abs(X(u) - X(v))^2)$, qui est entre autres, la moyenne empirique qui converge bien vers la quantité souhaitée sous hypothèse de dépendance faible comme vu en #ref(<annexe:weak_dep>).
