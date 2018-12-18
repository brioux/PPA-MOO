
$include parameters.gms

Variables z,z_buyer,E(t),Q(t),delta,c(t),f(t),l,K,theta(t),h,y ;


Positive variables
      E,Q,delta,f,c,l,K,theta,
      h,y,
      w_E(t)            weight on energy price target
      w_delta           weight on capacity price target
      w_l               weight on local content target
      w_h               weight on financial warranties
      w_y               weight on years of experience
      rho(t)
      phi(t)
      w_total
;
Equations

EQ_profit
EQ_theta(t)
EQ_caplim(t)
EQ_Q(t)
EQ_K
EQ_costv(t)
EQ_costf(t)


EQ_buyer
EQ_E_s(t)
EQ_delta_s
EQ_l_s
eq_5_5(t)
Eq_5_6(t)
EQ_h_s
EQ_y_s

EQ_norm

EQ_rho(t)
EQ_phi(t)
;


EQ_costv(t)..      c(t) =e= ci*(1-l) + l*cl;
EQ_costf(t)..      f(t) =e= fi*(1-l) + l*fl+y*tau_f+v*h;

EQ_theta(t)..     theta(t) =e= theta0 - eps_L*l +eps_h*h;

EQ_caplim(t)..       a-b*E(t) =l= (theta0 - eps_L*l +eps_h*h)*K*8.760;

EQ_profit..     z =e= sum(t,1/(1+exp(-(w_E(t)*(E_avg-E(t))/E_std
                        +w_delta*(delta_avg-delta)/delta_std
                        -w_h*(h_avg-h)/h_std
                        -w_l*(l_avg-l)/l_std
                        -w_y*(y_avg-y)/y_std)))*(
                        (E(t) - (ci*(1-l) + l*cl))*(a-b*E(t))+ (delta-(fi*(1-l) + l*fl+y*tau_f+v*h))*(K0-g*delta)
                        ))
;
EQ_buyer..      z_buyer =e= +1*(
                        (w_delta*(delta0-delta)/delta0)$(delta0>0)
                        +sum(t,w_E(t)*(E0-E(t)))/E0
                        +w_l*(l-l0)/l0
                        +w_h*(h-h0)/h0
                        +w_y*(y-y0)/y0)
;

EQ_E_s(t)..     (E(t)-E_avg)*E_std =l= (E0-E_avg)*E_std;
EQ_delta_s..     (delta-delta_avg)/delta_std =l= (delta0-delta_avg)/delta_std;
EQ_l_s..         -(l-l_avg)/l_std =l= -(l0-l_avg)/l_std;
EQ_h_s..         -(h-h_avg)/h_std =l= -(h0-h_avg)/h_std;
EQ_y_s..         -(y-y_avg)/y_std  =l= -(y0-y_avg)/y_std;

EQ_norm(t).. w_y+w_l+w_E(t)+w_delta+w_h =e=1;

EQ_rho(t).. rho(t) =e= 1/(1+exp(-phi(t)));

EQ_phi(t).. phi(t) =e=   w_E(t)*(E_avg-E(t))/E_std
                        +w_delta*(delta_avg-delta)/delta_std
                        -w_h*(h_avg-h)/h_std
                        -w_l*(l_avg-l)/l_std
                        -w_y*(y_avg-y)/y_std
;

EQ_Q(t).. Q(t) =e= a-b*E(t);
EQ_K.. K =e= K0-g*delta;

l.up = 1.0;
h.up = 1.0;
y.up = 10;

*w_h.fx=1;
*delta.fx=0;
*E.up(t) = 200 ;

*delta.up = 100 ;

*theta.lo(t) = 0.65
Model buyer /
EQ_buyer,
EQ_E_s,
EQ_delta_s,
EQ_l_s,
EQ_h_s,
EQ_y_s,
EQ_norm,
*EQ_rho,
*EQ_phi,
/;

model generator /
*EQ_costv,
*EQ_costf,
*EQ_theta,
EQ_caplim,
EQ_profit,
*EQ_K,
*EQ_Q
/

model PPA /buyer generator/;

PPA.optfile=1;
PPA.savePoint=2;

file myinfo /'%emp.info%'/;
put myinfo 'bilevel w_E w_delta w_h w_y w_l';
put 'max z * ';
put 'EQ_profit EQ_caplim '
$ontext
put 'EQ_E_s EQ_delta_s EQ_h_s EQ_y_s EQ_l_s';
put 'dualvar w_E EQ_E_s ';
put 'dualvar w_delta EQ_delta_s ';
put 'dualvar w_h EQ_h_s ';
put 'dualvar w_y EQ_y_s ';
put 'dualvar w_l EQ_l_s ';
$offtext

*EQ_K EQ_costf EQ_costv EQ_theta
*rho phi theta K Q c f
putclose / myinfo;
w_total.fx= 1;

$macro mean(xmin,xmax,aa,bb) (aa*xmax+bb*xmin)/(aa+bb);
$macro std(xmin,xmax,aa,bb) (xmax-xmin)*(aa*bb/((aa+bb+1)*(aa+bb)**2))**0.5;


Parameters  Shadow_E(t)
            Shadow_delta
            Shadow_l
            Shadow_h
            Shadow_y
            Shadow_Sum
            Shadow_theta
            CS consumer surplus
            Pi
            cost_ppa
            cost_gen
            fixed_cost
            marginal_cost
;


theta0 = 0.7;
theta_min = 0.6;
theta_max = 0.85;
theta_alpha = 5;
theta_beta = 1;
theta_avg = mean(theta_min,theta_max,theta_alpha,theta_beta);
theta_std = std(theta_min,theta_max,theta_alpha,theta_beta);

y_min = 5;
y_max = 10;
y_alpha = 2;
y_beta = 2;
y_avg = mean(y_min,y_max,y_alpha,y_beta);
y_std = std(y_min,y_max,y_alpha,y_beta);

h_min = 0.5;
h_max = 0.9;
h_alpha = 5;
h_beta = 1;
h_avg = mean(h_min,h_max,h_alpha,h_beta);
h_std = std(h_min,h_max,h_alpha,h_beta);

l0 = 0.3;
l_min = 0.3;
l_max = 0.5;
l_alpha = 2;
l_beta = 2;
l_avg = mean(l_min,l_max,l_alpha,l_beta);
l_std = std(l_min,l_max,l_alpha,l_beta);


* //////////////////////////////////////////////////////////////////
* scenario with low marginal cost/ energy price, high fixed cost and capacity price
ci = 10.5;
cl = 11.5;
cl = (cl -ci*(1-l0))/l0 ;

fi = 72.9;
fl = 188;
* calaculate fl such that fl above is the fixed cost under l0 % of local content
fl = (fl -fi*(1-l0))/l0 ;

* 10% increase in fixed/capital cost at targeted financial strength.
v = (fi*(1-l0) + l0*fl)*0.1/h0;

*1% cost slippage for each year of experience.
tau_f = (fi*(1-l0) + l0*fl)*0.01;

scalar E_mark_up markup on the energy price /1.03/ ;

$include energy_capacity_prices.gms

Solve PPA using EMP maximizing z_buyer ;
$include weights.gms

*$ontext

* //////////////////////////////////////////////////////////////////
* new scenario with higher marignal production cost (fuel reforms)
* and discounted capital cost.
* We reduce investment cost under 100% local content to 30% of the value calaculted above.
* The targeted capital/fixed cost at 20% local content
ci = 28.2;
cl = 28.2;

fl=fl*0.3;


v = (fi*(1-l0) + l0*fl)*0.1/h0;

tau_f = (fi*(1-l0) + l0*fl)*0.01;

*E_mark_up = 1.0126;
$include energy_capacity_prices.gms

Solve PPA using EMP maximizing z_buyer ;
$include weights.gms

*$offtext




