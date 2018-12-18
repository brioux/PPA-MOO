          Shadow_E(t) = EQ_E_s.m(t);
          Shadow_delta = EQ_delta_s.m ;
          Shadow_l = EQ_l_s.m ;
          Shadow_h = EQ_h_s.m ;
          Shadow_y = EQ_y_s.m ;
*          Shadow_theta = sum(t,EQ_5_6.m(t))/card(t);

Shadow_Sum = sum(t,Shadow_E(t))/card(t) + Shadow_delta + Shadow_l +Shadow_h + Shadow_y
*+Shadow_theta
;
$ontext
w_E.l(t)=  Shadow_E(t)/Shadow_Sum ;
w_delta.l= Shadow_delta/Shadow_Sum ;
w_l.l = Shadow_l/Shadow_Sum;
w_h.l = Shadow_h/Shadow_Sum;
w_y.l = Shadow_y/Shadow_Sum;
$offtext


parameter results, profit;

results('energy','target') = E0;
results('energy','value') = E.l('1');
results('energy','weight') = w_E.l('1');
*results('energy','shadow_w') = Shadow_E('1')/Shadow_Sum;
results('delta','target') = delta0;
results('delta','value') = delta.l;
results('delta','weight') = w_delta.l;
*results('delta','shadow_w') = Shadow_delta/Shadow_Sum;
results('local content','target') = l0;
results('local content','value') = l.l;
results('local content','weight') = w_l.l;
*results('local content','shadow_w') = Shadow_l/Shadow_Sum;
results('financial strenth','target') = h0;
results('financial strenth','value') = h.l;
results('financial strenth','weight') = w_h.l;
*results('financial strenth','shadow_w') = Shadow_h/Shadow_Sum;
results('years of experience','target') = y0;
results('years of experience','value') = y.l;
results('years of experience','weight') = w_y.l;
*results('years of experience','shadow_w') = Shadow_y/Shadow_Sum;
*$ontext
Q.l(t) = a-b*E.l(t);
K.l = K0-g*delta.l;
c.l(t) = ci*(1-l.l) + l.l*cl;
f.l(t) = fi*(1-l.l) + l.l*fl+y.l*tau_f+v*h.l ;
cost_ppa = sum(t,Q.l(t)*E.l(t))+delta.l*K.l;
cost_gen = sum(t,Q.l(t)*c.l(t))+delta.l*sum(t,f.l(t));

CS =sum(t,( (E_bar - E.l(t))*Q.l(t) + (delta_bar - delta.l)*K.l )/(1+i)**ord(t) );

profit = sum(t,(  (E.l(t)- c.l(t))*Q.l(t) + (delta.l - f.l(t))*K.l  )/(1+i)**(ord(t))) ;
Display results, profit;
;

Display fl,fi, cost_ppa, cost_gen;
*$offtext
