// ~ src/content/appendix/chap_etude_risque.tex

== Pourquoi viser l'estimation des couples d'incréments plutôt que la régularité <annexe:choix_risque_couple>
#include "couple_risk.typ"

== Peut-on considérer que tous les $Delta$ conviennent ? <annexe:tous_theta_conviennent_borne_norme_theta>
#include "borne_cible_varie.typ"

== Choix du risque : absolu ou relatif ? <annexe:choix-du-rique>
#include "absolu_vs_rel.typ"

== Etude de l'impact de la méthode de sélection de la fenêtre de pré-lissage sur le risque d'estimation des couples $Theta$
#include "h_glob_vs_indiv.typ"

== Gestion des valeurs extrêmes
#include "valeurs_extremes.typ"

== Graphes : indiv/global & valeurs extrêmes
#pagebreak(weak: true)
#include "h_glob_vs_indiv_graphs.typ"

== Lisser en utilisant une base de fonction sans écraser l'information irrégulière ? <annexe:lissage_base_fcn>
#include "prelissage_wavelet.typ"
