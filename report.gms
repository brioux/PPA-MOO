parameter results, report;

results(s,'energy price','opt') = P_opt(l.l,h.l);
results(s,'energy price','value') = P.l('1');
results(s,'energy price','weight') = w_P.l('1');
results(s,'energy price','average') = P_avg;
results(s,'energy price','std dev') = P_std;
results(s,'energy price','min') = P_min;
results(s,'energy price','max') = P_max;

results(s,'delta','opt') = delta_opt(l.l,h.l);
results(s,'delta','value') = delta.l;
results(s,'delta','weight') = w_delta.l;
results(s,'delta','average') = delta_avg;
results(s,'delta','std dev') = delta_std;
results(s,'delta','min') = delta_min;
results(s,'delta','max') = delta_max;

*results(s,'delta','shadow_w') = Shadow_delta/Shadow_Sum;
results(s,'local content','opt') = l0;
results(s,'local content','value') = l.l;
results(s,'local content','weight') = w_l.l;
results(s,'local content','average') = l_avg;
results(s,'local content','std dev') = l_std;
*results(s,'local content','shadow_w') = Shadow_l/Shadow_Sum;
results(s,'financial strenth','opt') = h0;
results(s,'financial strenth','value') = h.l;
results(s,'financial strenth','weight') = w_h.l;
results(s,'financial strenth','average') = h_avg;
results(s,'financial strenth','std dev') = h_std;
*results(s,'financial strenth','shadow_w') = Shadow_h/Shadow_Sum;
results(s,'years of experience','opt') = y0;
results(s,'years of experience','value') = y.l;
results(s,'years of experience','weight') = w_y.l;
results(s,'years of experience','average') = y_avg;
results(s,'years of experience','std dev') = y_std;
*results(s,'years of experience','shadow_w') = Shadow_y/Shadow_Sum;
*$ontext


report(s,"phi") = z_buyer.l;
report(s,"rh0") = RHO(report(s,"phi"));
report(s,"w_p") = sum(t,w_P.l(t));
report(s,"w_delta") = w_delta.l;
report(s,"w_h") = w_h.l;
report(s,"w_l") = w_l.l;
report(s,"w_y") = w_y.l;
report(s,"PPA cost") = sum(t,Q(P.l(t))*P.l(t))+delta.l*K(delta.l);
report(s,"Generator cost") = sum(t,Q(P.l(t)))*c(l.l)+K(delta.l)*sum(t,f(l.l,y.l,h.l));
report(s,"profit") =
*z.l;
*profit(P.l('1'),delta.l,l.l,y.l,h.l);
(P.l('1') - c(l.l))*Q(P.l('1')) + (delta.l-f(l.l,y.l,h.l))*K(delta.l) ;
report(s,"Production") = Q(P.l('1'));
report(s,"Capacity") = K(delta.l);
report(s,"Theta") = theta(l.l,h.l);
report(s,"Energy price") = P.l('1');
report(s,"Capacity price") = delta.l;
report(s,"a") = a;
report(s,"b") = b;
report(s,"g") = g;
report(s,"K0") = k0;
report(s,"marginal cost") = c(l.l);
report(s,"fixed cost") = f(l.l,y.l,h.l);
report(s,'nu') = nu(l.l,h.l);
*CS =sum(t,( (P_bar - P.l(t))*Q.l(t) + (delta_bar - delta.l)*K.l )/(1+i)**ord(t) );
;
*$offtext
