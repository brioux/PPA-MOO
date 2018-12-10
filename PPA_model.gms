

option nlp=pathnlp;

Sets       j     companies /1*1/
           t     Time     /1*1/
           ;
parameters
            a            Intercept of the CDF of the uniform dist/1/
            b            slope of the CDF of the uniform dist/1/
            r_max        Highest possible ranking/5/
            r_min        Lowest possible ranking/1/
            l0           percentage of local content/0.3/
            l_min,l_max,l_avg,l_std,l_alpha,l_beta

            E0           the target price of electricity ($ per Mwh) /16/
            E_bar        The maximum price of electricity USD per MWh /100/
            E_min,E_max,E_avg,E_std,E_alpha,E_beta

            delta0       the target capacity price ($ per KW)       /145/
            delta_bar    The maximum price of capacity USD per KW /150/
            delta_min,delta_max,delta_avg,delta_std,delta_alpha,delta_beta
            g           slope on the capacity equation

            K0           the installed capacity  kw /3.93e6/

            theta0        /0.7 /
            theta_bar     /0.6 /
            theta_min,theta_max,theta_avg,theta_std,theta_alpha,theta_beta

            y0           minimum years of experience /5/
            y_bar        the targeted number of years of experience/10/
            y_min,y_max,y_avg,y_std,y_alpha,y_beta

            h0           minimum financial strength factor /0.75/
            h_min,h_max,h_avg,h_std,h_alpha,h_beta

            v            factor for the increase of project costs due to higher financial strength

            tau_c        the impact of the number of years of lack of experience on cost slippage
            tau_f        the impact of the number of years of lack of experience on cost slippage

            eps_l        /0.05/
            eps_y        /0.005/
            eps_h        /0.01/

            i            discount rate   /0.05 /

            ci           International marginal cost $ per Mwh /15/
            cl           100% local content marginal cost $ per Mwh /15/
            fi           annualized capital cost of equipment USD per KW (CCGT)/188/
            fl           domestic capital cost of equipment USD per KW (CCGT) /188/

            pi_min       minimum profit /1000/

            wE
            wD
            wH
            wL
            wY
;

a = - r_min/(r_max- r_min) ;
b = 1/(r_max -r_min) ;

Variables z2,z, E(t),Q(t), delta,c(t),o(t),f(t),l,K,theta(t) ;
variables h,y ;


Positive variables
      E,Q,delta,o,f,c,l,K,theta,
      h,y,
      w_E(t),w_delta,w_l,w_h,w_y
;
Equations

EQ_theta(t)
Eq_Q(t)
EQ_p(t)
EQ_K
EQ3(t)
EQ4(t)

EQ_profit
EQ_E_s(t)
EQ_delta_s
EQ_l_s
eq_5_5(t)
Eq_5_6(t)
EQ_h_s
EQ_y_s

EQ_norm
;


EQ3(t)..      c(t) =e= ci*(1-l) + l*cl;
EQ4(t)..      f(t) =e= fi*(1-l) + l*fl+y*tau_f+v*h;

EQ_theta(t)..     theta(t) =e= theta0 - eps_L*l +eps_h*h;

Eq_Q(t)..       Q(t) =e= theta(t)*K*8.760;

EQ_profit..     z =e= sum(t,(  (E(t)- c(t))*Q(t) + (delta-(f(t)))*K  )/(1+i)**(ord(t)));

EQ_E_s(t)..      (E(t)-E_avg)/E_std =l= (E0-E_avg)/E_std ;
EQ_delta_s..         (delta-Delta_avg)/Delta_std =l= (delta0-Delta_avg)/Delta_std;
EQ_l_s..         (l0-l_avg)/l_std =l= (l-l_avg)/l_std ;
EQ_h_s..         (h0-h_avg)/h_std =l= (h-h_avg)/h_std  ;
EQ_y_s..         (y0-y_avg)/y_std  =l= (y-y_avg)/y_std;

EQ_norm(t).. w_y+w_l+w_E(t)+w_delta+w_h =e=1;


EQ_p(t).. E(t) =e= a-b*Q(t);
EQ_K.. K =e= K0-g*delta;

l.up = 1.0;
*E.up(t) = 200 ;
*delta.up = 100 ;

theta.lo(t) = 0.65
Model PPA /

EQ3,
EQ4,
EQ_theta,
Eq_Q,
EQ_profit,
EQ_K

EQ_E_s,
EQ_delta_s,
EQ_l_s,
EQ_h_s,
EQ_y_s,
EQ_norm

/;

file myinfo /'%emp.info%'/;
put myinfo 'DualVar w_E(t) EQ_E_s';
put 'DualVar w_y EQ_y_s';
put 'DualVar w_l EQ_l_s';
put 'DualVar w_delta EQ_delta_s';
put 'DualVar w_h EQ_h_s';
putclose / myinfo;



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
ci = 11.5;
cl = 11.5;

fi = 72.9;
fl = 188;
* calaculate fl such that fl above is the fixed cost under l0 % of local content
fl = (fl -fi*(1-l0))/l0 ;

* 10% increase in fixed/capital cost at targeted financial strength.
v = (fi*(1-l0) + l0*fl)*0.1/h0;

*1% cost slippage for each year of experience.
tau_f = (fi*(1-l0) + l0*fl)*0.01;

scalar E_mark_up markup on the energy price (amrginal revenue) /1.03/ ;
$include energy_capacity_prices.gms

Solve PPA using EMP maximizing z;
$include weights.gms

* //////////////////////////////////////////////////////////////////
* new scenario with higher marignal production cost (fuel reforms)
* and discounted capital cost.
* We reduce investment cost under 100% local content to 30% of the value calaculted above.
* The targeted capital/fixed cost at 20% local content
ci = 28.2;
cl = 28.2;

fl=fl*0.3;


v = (fi*(1-l0) + l0*fl)*0.1/h0;

tau_c = (ci*(1-l0) + l0*cl)*0.01;
tau_f = (fi*(1-l0) + l0*fl)*0.01;

*E_mark_up = 1.0126;
$include energy_capacity_prices.gms

*theta.fx(t) = theta.l(t);

Solve PPA using EMP maximizing z ;
$include weights.gms

$exit




