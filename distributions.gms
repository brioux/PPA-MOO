theta0 = 0.7;
theta_min = 0.6;
theta_max = 0.85;
theta_alpha = 5;
theta_beta = 1;
theta_avg = mean(theta_min,theta_max,theta_alpha,theta_beta);
theta_std = std(theta_min,theta_max,theta_alpha,theta_beta);

y0 = 5;
y_min = 2;
y_max = 10;
y_alpha = 2;
y_beta = 5;
y_avg = mean(y_min,y_max,y_alpha,y_beta);
y_std = std(y_min,y_max,y_alpha,y_beta);

h0 = 0.75;
h_min = 0.6;
h_max = 0.9;
h_alpha = 2;
h_beta = 2;
h_avg = mean(h_min,h_max,h_alpha,h_beta);
h_std = std(h_min,h_max,h_alpha,h_beta);

l0 = 0.3;
l_min = 0.1;
l_max = 0.5;
l_alpha = 1;
l_beta = 3;
l_avg = mean(l_min,l_max,l_alpha,l_beta);
l_std = std(l_min,l_max,l_alpha,l_beta);


delta_alpha = 4;
delta_beta = 4;

P_alpha = 4;
P_beta = 4;