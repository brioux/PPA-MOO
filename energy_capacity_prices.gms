
marginal_cost = (ci*(1-l0) + l0*cl) ;
fixed_cost = fi*(1-l0) + l0*fl+y0*tau_f+v*h0;

delta0 = fixed_cost*1.2;
delta_min = fixed_cost;
delta_max = fixed_cost+marginal_cost*(theta0 - eps_L*l0 +eps_h*h0)*8.76;
delta_alpha = 1;
delta_beta = 5;
delta_avg = mean(delta_min,delta_max,delta_alpha,delta_beta);
delta_std = std(delta_min,delta_max,delta_alpha,delta_beta);

K0=K0*(1+0.2$(delta0>0));
g = (0.2*K0/delta0)$(delta0>0)+0$(delta0=0);

E0 = marginal_cost*E_mark_up;
E_min = 0;
E_max = marginal_cost;
E_alpha = 5;
E_beta = 1;
E_avg = mean(E_min,E_max,E_alpha,E_beta);
E_std = std(E_min,E_max,E_alpha,E_beta);


a = (theta0 - eps_L*l0 +eps_h*h0)*(K0-g*delta0)*8.760 ;
b = a/E0;
a = 2*a;
display delta_avg,delta_std,E_avg,E_std;
