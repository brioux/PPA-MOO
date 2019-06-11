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

marginal_cost = c(l0);
fixed_cost = f(l0,y0,h0);

delta0 = fixed_cost*delta_mark_up;
delta_min = fixed_cost*1;
delta_max = fixed_cost*1.5;
*fixed_cost+marginal_cost*(theta0 - eps_L*l0 +eps_h*h0)*8.76;

delta_avg = mean(delta_min,delta_max,delta_alpha,delta_beta);
delta_std = std(delta_min,delta_max,delta_alpha,delta_beta);

P0 = marginal_cost*P_mark_up;
P_min = marginal_cost*1;
P_max = marginal_cost*1.5;
*marginal_cost+fixed_cost/(theta0 - eps_L*l0 +eps_h*h0)/8.76;
P_avg = mean(P_min,P_max,P_alpha,P_beta);
P_std = std(P_min,P_max,P_alpha,P_beta);


k0=1;
K0=K0*(1+0.2$(delta_avg>0));
g = (0.2*K0/delta_avg)$(delta_avg>0)+0$(delta_avg=0);

a = theta(l.l,h.l)*K(delta0);
a = 2*a;
b = a/P0;

P.l(t) = P_opt(l.l,h.l);
*P.up(t) = P_opt(l.l,h.l);
delta.l = delta_opt(l.l,h.l);






