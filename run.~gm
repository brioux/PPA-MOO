$ontext
      Multi objective optimization problem for Purchase Power Agreements
      Model constructed by Dernando Olveira and Bertrand Rioux
      Add open source copyright protection agreement
$offtext

$macro mean(xmin,xmax,aa,bb) (aa*xmax+bb*xmin)/(aa+bb);
$macro std(xmin,xmax,aa,bb) (xmax-xmin)*(aa*bb/((aa+bb+1)*(aa+bb)**2))**0.5;

$include parameters.gms
$include distributions.gms

$include PPA_model.gms

scalar E_mark_up markup for the energy price /1.07/
       delta_mark_up markup for the capacity price /1.07/
;

* ////////////////////////////////////
* the code belwo tis to drop local content,
* financial strength and years of expeience
* from the two level problem

l0=0;
h0=0;
y0=0;

* fix other generator variables
h.fx=0;
l.fx=0;
y.fx=0;
* fix buyer weights
w_h.fx = 0;
w_l.fx=0;
w_y.fx=0;

s(scenario) = no;
s("high") = yes;
* //////////////////////////////////////////////////////////////////
* scenario with  high fixed cost/capacity price, and low marignal cost/ energy price
ci = 10.67;
c0 = ci*E_mark_up;

fi = 72.9;
f0 = 188;

$include energy_capacity_prices.gms

Solve PPA using EMP maximizing z_buyer ;
$include report.gms

$ontext
s(scenario) = no;
s("low") = yes;

* //////////////////////////////////////////////////////////////////
* new scenario with higher marignal production cost (fuel reforms)
* and discounted capital cost.
* We reduce investment cost under 100% local content to 30% of the value calaculted above.
* The targeted capital/fixed cost at 20% local content
ci = 28.2;
c0 = ci*E_mark_up;
f0=f0*0.5;

$include energy_capacity_prices.gms
Solve PPA using EMP maximizing z_buyer ;
$include report.gms
$offtext

$ontext
s(scenario) = no;
s("volatility") = yes;

* //////////////////////////////////////////////////////////////////
* new scenario with higher marignal production cost (fuel reforms)
* and discounted capital cost.
* We reduce investment cost under 100% local content to 30% of the value calaculted above.
* The targeted capital/fixed cost at 20% local content
E_alpha = 2;
E_beta = 2;


*E_mark_up = 1.0126;
$include energy_capacity_prices.gms
Solve PPA using EMP maximizing z_buyer ;
$include weights.gms
$offtext



