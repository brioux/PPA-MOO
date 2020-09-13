option nlp=pathnlp;

Sets       j     companies /1*1/
           t     Time     /1*1/
           sl    weights /1*11/
           ;
parameters
            a            Intercept the demand funciton /17.25/
            b            slope of the demand function /1.083/

            E0           Electriticy expected ($ per Mwh) /12.84/
            E_sd         SD of electricity ($ per Mwh)/0.8239/

            delta0       expected capacity price ($ per KW)       /258/
            delta_sd     SD of capacity USD per KW                /13.5/

            theta        parameter for minimum available capacity for K /0.7/
            m            /1.2 /

            g            /0.000928433268858801 /

            y0           Expected value years of experience /4.28571428571429/
            y_sd          /1.27775312999988/


            l0           expected  local contact              /0.2/
            l_sd                                              /0.0774596669241484/



            h0           expected  financial strength factor /0.75/
            h_sd                                              /0.1/

            c_i              /5/
            c_L              /10/

            f_i             /188/
            f_L             /250/

            tau           /0.4/
            mu            /0.2/

            theta_low        parameter for minimum available capacity for K /0.7/

            epsilon_L                  /0.02/
            epsilon_h                  /0.01/;



Variables delta, E, nu;


*************************************************
*************************************************
*****Buyer's Problem            ****************
*************************************************
*************************************************
Variables
W_delta
W_E
W_h
W_l
W_y;


variables delta_margin, E_margin, h_margin, l_margin, y_margin;
variables h, l, y;
variables phi, rho;

Equations
Prob_1,
Profit_eq,

Prop_3_delta,
Prop_3_p,
Prop_3_nu,

delta_marg_eq,
E_marg_eq,
h_marg_eq,
l_marg_eq,
y_marg_eq,

h_eq,
l_eq,
y_eq,
phi_eq,
rho_eq;



**************************************************************************
Prob_1.. W_delta+W_E+W_h+W_l+W_y=e=1;
delta_marg_eq..  delta_margin =e= (delta0-delta)/delta_sd;
E_marg_eq.. E_margin          =e= (E0-E)/E_sd;
h_marg_eq.. h_margin          =e= (h-h0)/h_sd;
l_marg_eq.. l_margin          =e= (l-l0)/l_sd;
y_marg_eq.. y_margin          =e= (y-y0)/y_sd;


h_eq.. h =e= h0-h_sd*nu;
l_eq.. l =e= l0-l_sd*nu;
y_eq.. y =e= y0-y_sd*nu;


phi_eq.. phi =e= - nu;
rho_eq.. rho =e=1/(1+exp(nu));


Prop_3_delta.. delta=e=((a-b*E0 -theta*8.760*m)*delta_sd+b*delta0*E_sd)/(b*E_sd-theta*8.760*g*delta_sd);

Prop_3_p.. E =e= (-theta*8.760*g*E0*delta_sd+(a-theta*8.760*m +theta*8.760* g*delta0)*E_sd)/(b*E_sd-theta*8.760*g*delta_sd);

Prop_3_nu.. nu=e=(a-b*E0 -theta*8.760*m+theta*8.760*g*delta0)/(b*E_sd-theta*8.760*g*delta_sd);

Profit_eq..       phi=e= W_delta*delta_margin+W_E*E_margin+W_h*h_margin+W_l*l_margin+W_y*y_margin;


Model buyer /all/;
Solve buyer using nlp maximizing phi;


Parameters c, f, theta_true;

c = c_i*(1-l.l)+c_L*l.l;

f = f_i*(1-l.l)+f_L*l.l+tau*y.l+mu*h.l;

theta_true = theta_low-epsilon_l*l.l+epsilon_h*h.l;

display c, f, theta_true;
display delta.l, E.l, nu.l, phi.l, rho.l, h.l, l.l, y.l;
display delta_margin.l, E_margin.l, h_margin.l, l_margin.l, y_margin.l;
display      W_delta.l,W_E.l,W_h.l,W_l.l,W_y.l;

