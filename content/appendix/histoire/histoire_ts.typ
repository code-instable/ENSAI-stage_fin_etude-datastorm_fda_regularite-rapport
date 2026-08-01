// ~ src/content/appendix/histoire/histoire_ts.tex
#import "../../../lib/math.typ": *
#import "../../../lib/components.typ": info

#info[une grande partie des informations présentées dans cette section histoire provient de la référence #cite(<time_series_brief_history>)]

Parmi les étapes importantes du développement des séries temporelles, on peut noter l'article _Time Series Analysis : Forecasting and Control_ de Box et Jenkins (1970) qui introduit le modèle ARIMA et une approche aujourd'hui standarde d'évaluation du modèle à utiliser ainsi que son estimation. Ce développement est dû en grande partie à l'utilisation de telles données dans les secteurs économiques et des affaires afin de suivre l'évolution et la dynamique de différentes métriques

L'étude des séries temporelle a été divisée en l'étude du domaine fréquentiel, qui étudie le spectre des processus pour le décomposer en signaux principaux, et du domaine temporel, qui étudie les dépendances des indices temporels. L'utilisation de chacune des approches était sujet à débats mouvementés jusqu'aux alentours de l'an $2000$.

Le développement des capacités de calcul a été une révolution notamment pour l'identification des modèles (le critère AIC, l'estimation par vraissemblance dans les années $1980$, …).

À partir des années $1980$, les modèles non linéaires émergent (ARCH par Engle, modèles à seuil …) et trouvent application en économie notamment. Enfin l'étude multivariée (modèle VAR) fait surface dans les années 1980 par Christopher Sims#cite(<VAR_paper>, supplement: link("https://pubs.aeaweb.org/doi/pdf/10.1257/jep.15.4.101")[lien de l'article])

Une large partie de la théorie s'appuie notamment sur l'étude des racines de l'unité, en considérant un polynôme d'opérateur $P(B) = (I + sum_k a_k B^k)$ à partir duquel les relations d'autocorrélations peuvent se ré-écrire.
