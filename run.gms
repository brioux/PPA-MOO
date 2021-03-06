$ontext
      Multi objective optimization problem for Purchase Power Agreements
      Model constructed by Dernando Olveira and Bertrand Rioux
      Add open source copyright protection agreement
$offtext

* mean and standard deviation for a beta distribution with max min and paramers aa, bb
$macro mean(xmin,xmax,aa,bb) (aa*xmax+bb*xmin)/(aa+bb);
$macro std(xmin,xmax,aa,bb) (xmax-xmin)*(aa*bb/((aa+bb+1)*(aa+bb)**2))**0.5;

$include parameters.gms
$include distributions.gms

$include PPA_model.gms

scalar P_mark_up markup for the energy price /1.07/
       delta_mark_up markup for the capacity price /1.07/
;

* ////////////////////////////////////
* the code belwo tis to drop local content,
* financial strength and years of expeience
* from the two level problem

s(scenario) = no;
s("high") = yes;
* //////////////////////////////////////////////////////////////////
* scenario with  high fixed cost/capacity price, and low marignal cost/ energy price
ci = 10.67;
c0 = ci*P_mark_up;

fi = 72.9;
f0 = 188;

* fix other generator variables to some target
h.fx=h0;
l.fx=l0;
y.fx=y0;
* fix corr buyer weights
w_h.fx=0;
w_l.fx=0;
w_y.fx=0;

$include energy_capacity_prices.gms




* setup bilevel problem using EMP
file myinfo /'%emp.info%'/;
put myinfo 'bilevel w_P w_delta w_h w_l w_y';
put 'max z * EQ_profit EQ_caplim';
putclose / myinfo;

PPA.optfile=1;

Solve PPA using EMP maximizing z_buyer ;
$ontext
* dual primal relationships for generators optimality conditions
* this formulation is not correct as it solves a standard MCP not a bilevel problem
file myinfo /'%emp.info%'/;
put myinfo 'dualvar zeta EQ_caplim';
put 'dualequ EQ_opt_delta delta';
put 'dualequ EQ_opt_p P';
putclose / myinfo;
Solve buyer_gen_opt using EMP maximizing z_buyer ;
$offtext

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
c0 = ci*P_mark_up;
f0=f0*0.5;

$include energy_capacity_prices.gms

Solve PPA using EMP maximizing z_buyer;
*Solve buyer_gen_opt maximizing z_buyer using NLP;
$include report.gms
*$offtext

$ontext
s(scenario) = no;
s("volatility") = yes;

* //////////////////////////////////////////////////////////////////
* new scenario with higher marignal production cost (fuel reforms)
* and discounted capital cost.
* We reduce investment cost under 100% local content to 30% of the value calaculted above.
* The targeted capital/fixed cost at 20% local content
P_alpha = 2;
P_beta = 2;


*P_mark_up = 1.0126;
$include energy_capacity_prices.gms
Solve PPA using EMP maximizing z_buyer ;
$include weights.gms
$offtext



