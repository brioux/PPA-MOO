*5% increase in capital cost at targeted financial strength
mu = 0.05;
*5% increase in capital cost at targeted years of experience
tau_f = 0.05;

cl$(l0>0) = (c0 -ci*(1-l0))/l0 ;
fl$(l0>0) = (f0/(1+mu+tau_f) -fi*(1-l0))/l0 ;

* 10% increase in fixed/capital cost at targeted financial strength.
mu$(h0>0) = (fi*(1-l0) + l0*fl)*mu/h0;
*1% cost slippage for each year of experience.
tau_f$(y0>0) = (fi*(1-l0) + l0*fl)*tau_f/y0;


marginal_cost = (ci*(1-l0) + l0*cl);
fixed_cost = fi*(1-l0) + l0*fl+mu*h0+tau_f*y0;
display fixed_cost;

delta0 = fixed_cost*delta_mark_up;
delta_min = fixed_cost*0.9;
delta_max = fixed_cost*1.1;
*fixed_cost+marginal_cost*(theta0 - eps_L*l0 +eps_h*h0)*8.76;

delta_avg = mean(delta_min,delta_max,delta_alpha,delta_beta);
delta_std = std(delta_min,delta_max,delta_alpha,delta_beta);

P0 = marginal_cost*P_mark_up;
P_min = marginal_cost*0.9;
P_max = marginal_cost*1.1;
*marginal_cost+fixed_cost/(theta0 - eps_L*l0 +eps_h*h0)/8.76;
P_avg = mean(P_min,P_max,P_alpha,P_beta);
P_std = std(P_min,P_max,P_alpha,P_beta);

k0=1;
K0=K0*(1+0.2$(delta0>0));
g = (0.2*K0/delta_avg)$(delta0>0)+0$(delta0=0);
a = (theta0 - eps_L*l0 +eps_h*h0)*(K0-g*delta0)*8.760 ;
a = 2*a;
b = a/P_avg;
