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
w_E(t)=  Shadow_E(t)/Shadow_Sum ;
w_delta= Shadow_delta/Shadow_Sum ;
w_l = Shadow_l/Shadow_Sum;
w_h = Shadow_h/Shadow_Sum;
w_y = Shadow_y/Shadow_Sum;
$offtext

cost_ppa = sum(t,Q.l(t)*E.l(t))+delta.l*K.l;
cost_gen = sum(t,Q.l(t)*c.l(t))+delta.l*sum(t,f.l(t));

CS =sum(t,( (E_bar - E.l(t))*Q.l(t) + (delta_bar - delta.l)*K.l )/(1+i)**ord(t) );

Pi = sum(t,(  (E.l(t)- c.l(t))*Q.l(t) + (delta.l - f.l(t))*K.l  )/(1+i)**(ord(t))) ;
Display E.l,l.l,delta.l,z.l,h.l,y.l,CS,Pi,w_l.l,w_E.l,w_delta.l,w_h.l,w_y.l,Q.l,theta.l
*w_theta
;

Display fl,fi, cost_ppa, cost_gen;

