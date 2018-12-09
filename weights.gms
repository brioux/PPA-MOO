          Shadow_E = sum(t, Eq_5_2.m(t))/card(t) ;
          Shadow_delta = Eq_5_3.m ;
          Shadow_l = Eq_5_4.m ;
          Shadow_h = Eq_5_7.m ;
          Shadow_y = Eq_5_8.m ;
*          Shadow_theta = sum(t,EQ_5_6.m(t))/card(t);

Shadow_Sum = Shadow_E + Shadow_delta + Shadow_l +Shadow_h + Shadow_y
*+Shadow_theta
;

w_E=  Shadow_E/Shadow_Sum ;
w_delta= Shadow_delta/Shadow_Sum ;
w_l = Shadow_l/Shadow_Sum;
w_h = Shadow_h/Shadow_Sum;
w_y = Shadow_y/Shadow_Sum;
*w_theta = Shadow_theta/Shadow_Sum ;

cost_ppa = sum(t,Q.l(t)*E.l(t))+delta.l*K.l;
cost_gen = sum(t,Q.l(t)*c.l(t))+delta.l*sum(t,f.l(t)+o.l(t));

CS =sum(t,( (E_bar - E.l(t))*Q.l(t) + (delta_bar - delta.l)*K.l )/(1+i)**ord(t) );

Pi = sum(t,(  (E.l(t)- c.l(t))*Q.l(t) + (delta.l - (o.l(t)+f.l(t)))*K.l  )/(1+i)**(ord(t))) ;
Display E.l,l.l,delta.l,z.l,h.l,y.l,CS,Pi,w_l,w_E,w_delta,w_h,w_y,Q.l,theta.l
*w_theta
;

Display fl,fi, cost_ppa, cost_gen;

