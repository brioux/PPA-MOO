$ontext
          Shadow_E(t) = EQ_E_s.m(t);
          Shadow_delta = EQ_delta_s.m ;
          Shadow_l = EQ_l_s.m ;
          Shadow_h = EQ_h_s.m ;
          Shadow_y = EQ_y_s.m ;
*          Shadow_theta = sum(t,EQ_5_6.m(t))/card(t);
Shadow_Sum = sum(t,Shadow_E(t))/card(t) + Shadow_delta + Shadow_l +Shadow_h + Shadow_y
*+Shadow_theta
;

w_E.l(t)=  Shadow_E(t)/Shadow_Sum ;
w_delta.l= Shadow_delta/Shadow_Sum ;
w_l.l = Shadow_l/Shadow_Sum;
w_h.l = Shadow_h/Shadow_Sum;
w_y.l = Shadow_y/Shadow_Sum;
$offtext


parameter results, report;

results(s,'energy','target') = E0;
results(s,'energy','value') = E.l('1');
results(s,'energy','weight') = w_E.l('1');
results(s,'energy','average') = E_avg;
results(s,'energy','std dev') = E_std;
results(s,'energy','std min') = E_min;
results(s,'energy','std max') = E_max;

*results(s,'energy','shadow_w') = Shadow_E('1')/Shadow_Sum;
results(s,'delta','target') = delta0;
results(s,'delta','value') = delta.l;
results(s,'delta','weight') = w_delta.l;
results(s,'delta','average') = delta_avg;
results(s,'delta','std dev') = delta_std;
results(s,'delta','std min') = delta_min;
results(s,'delta','std max') = delta_max;

*results(s,'delta','shadow_w') = Shadow_delta/Shadow_Sum;
results(s,'local content','target') = l0;
results(s,'local content','value') = l.l;
results(s,'local content','weight') = w_l.l;
results(s,'local content','average') = l_avg;
results(s,'local content','std dev') = l_std;
*results(s,'local content','shadow_w') = Shadow_l/Shadow_Sum;
results(s,'financial strenth','target') = h0;
results(s,'financial strenth','value') = h.l;
results(s,'financial strenth','weight') = w_h.l;
results(s,'financial strenth','average') = h_avg;
results(s,'financial strenth','std dev') = h_std;
*results(s,'financial strenth','shadow_w') = Shadow_h/Shadow_Sum;
results(s,'years of experience','target') = y0;
results(s,'years of experience','value') = y.l;
results(s,'years of experience','weight') = w_y.l;
results(s,'years of experience','average') = y_avg;
results(s,'years of experience','std dev') = y_std;
*results(s,'years of experience','shadow_w') = Shadow_y/Shadow_Sum;
*$ontext


report(s,"phi") = z_buyer.l;
report(s,"rh0") = RHO(report(s,"phi"));
report(s,"w_p") = sum(t,w_E.l(t));
report(s,"w_delta") = w_delta.l;
report(s,"w_h") = w_h.l;
report(s,"w_l") = w_l.l;
report(s,"w_y") = w_y.l;
report(s,"PPA cost") = sum(t,Q(E.l(t))*E.l(t))+delta.l*K(delta.l);
report(s,"Generator cost") = sum(t,Q(E.l(t)))*c(l.l)+K(delta.l)*sum(t,f(l.l,y.l,h.l));
report(s,"profit") = z.l;
*profit(E.l('1'),delta.l,l.l,y.l,h.l);
report(s,"Production") = Q(E.l('1'));
report(s,"Capacity") = K(delta.l);
report(s,"Theta") = theta(l.l,h.l);
report(s,"Energy price") = E.l('1');
report(s,"Capacity price") = delta.l;
report(s,"a") = a;
report(s,"b") = b;
report(s,"g") = g;
report(s,"K0") = k0;
report(s,"marginal cost") = c(l.l);
report(s,"fixed cost") = f(l.l,y.l,h.l);
*CS =sum(t,( (E_bar - E.l(t))*Q.l(t) + (delta_bar - delta.l)*K.l )/(1+i)**ord(t) );
;
*$offtext
