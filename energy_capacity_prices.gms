
marginal_cost = (ci*(1-l0) + l0*cl+(y_bar-y0)*tau_c) ;
fixed_cost = fi*(1-l0) + l0*fl+(y_bar-y0)*tau_f+v*h0 + (oi*(1-l0) + l0*ol+(y_bar-y0)*tau_o);

delta0 = fixed_cost;
delta_min = 0;
delta_max = fixed_cost+marginal_cost*theta0*8.76;
delta_alpha = 5;
delta_beta = 1;
delta_avg = mean(delta_min,delta_max,delta_alpha,delta_beta);
delta_std = std(delta_min,delta_max,delta_alpha,delta_beta);

g = K0*0.2/(delta_max-delta0);


E0 = marginal_cost*E_mark_up;
E_min = 0;
E_max = marginal_cost+fixed_cost/(theta0*8.76);
E0 = E_min;
E_alpha = 1;
E_beta = 5;
E_avg = mean(E_min,E_max,E_alpha,E_beta);
E_std = std(E_min,E_max,E_alpha,E_beta);

display delta_avg,delta_std,E_avg,E_std;
