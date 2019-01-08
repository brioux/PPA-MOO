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

scalar E_mark_up markup on the energy price /1.07/
       delta_mark_up markup on the capacity price /1.07/
;

s(scenario) = no;
s("high") = yes;
* //////////////////////////////////////////////////////////////////
* scenario with low marginal cost/ energy price, high fixed cost and capacity price
ci = 10.67;
c0 = ci*1.05;
fi = 72.9;
f0 = 188;

$include energy_capacity_prices.gms

Solve PPA using EMP maximizing z_buyer ;
$include weights.gms


s(scenario) = no;
s("low") = yes;
*$ontext
* //////////////////////////////////////////////////////////////////
* new scenario with higher marignal production cost (fuel reforms)
* and discounted capital cost.
* We reduce investment cost under 100% local content to 30% of the value calaculted above.
* The targeted capital/fixed cost at 20% local content
ci = 28.2;
c0 = ci*1.05;
f0=f0*0.5;

*E_mark_up = 1.0126;
$include energy_capacity_prices.gms
Solve PPA using EMP maximizing z_buyer ;
$include weights.gms
*$offtext


s(scenario) = no;
s("volatility") = yes;
*$ontext
* //////////////////////////////////////////////////////////////////
* new scenario with higher marignal production cost (fuel reforms)
* and discounted capital cost.
* We reduce investment cost under 100% local content to 30% of the value calaculted above.
* The targeted capital/fixed cost at 20% local content
E_alpha = 5;
E_beta = 5;


*E_mark_up = 1.0126;
$include energy_capacity_prices.gms
Solve PPA using EMP maximizing z_buyer ;
$include weights.gms
*$offtext



