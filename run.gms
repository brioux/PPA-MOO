$ontext
      Multi objective optimization problem for Purchase Power Agreements
      Model constructed by Dernando Olveira and Bertrand Rioux
      Add open source copyright protection agreement
$offtext

$include parameters.gms
$include PPA_model.gms


theta0 = 0.7;
a = 13.255;
b = 1.083;
K0 = 1.2;
g = 0.000928;

P_avg = 12.844;
P_std = 0.8239;
delta_avg = 258;
delta_std = 13.5;
y_avg = 4.285714;
y_std = 1.277753;
h_avg = 0.75;
h_std = 0.067082;
l_avg = 0.2;
l_std = 0.07746;

* local and internatinoal cost parameters
ci = 5;
cl = 10;
fi = 188;
fl = 250;

* other parameters l,h, and y
eps_L = 0;
eps_h = 0;
mu = 0;
tau_f = 0;

*$ontext
* initialize values
p.l = 6.20;
delta.l = 149.1522;
y.l = 14.588;
l.l = 0.8245;
h.l = 1.29;
*$offtext


$ontext
* ////////////////////////////////////
* the code belwo tis to drop local content,
* financial strength and years of expeience
* from the two level problem
* fix other generator variables to some target
h.fx=0.8;
l.fx=0.3;
y.fx=5;
* fix buyer weights
w_h.fx=0;
w_l.fx=0;
w_y.fx=0;
$offtext


* setup bilevel problem using EMP
file myinfo /'%emp.info%'/;
put myinfo 'bilevel w_P w_delta w_h w_l w_y';
put 'max z * EQ_profit EQ_caplim';
putclose / myinfo;

PPA.optfile=1;

Solve PPA using EMP maximizing z_buyer ;

*$include report.gms



