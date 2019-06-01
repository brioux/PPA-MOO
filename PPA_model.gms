option nlp=pathnlp;

Variables z,z_buyer,E(t),delta,l,h,y ;
Positive variables
      E,delta,l,
      h,y,
      w_E(t)            weight on energy price target
      w_delta           weight on capacity price target
      w_l               weight on local content target
      w_h               weight on financial warranties
      w_y               weight on years of experience
      w_total
;

Equations
EQ_profit         "generator's profit"
EQ_caplim(t)      generators capacity limit constraint

EQ_buyer
EQ_E_s(t)
EQ_delta_s
EQ_l_s
eq_5_5(t)
Eq_5_6(t)
EQ_h_s
EQ_y_s
EQ_norm
EQ_q_pos(t)  generator production shold be non-negative
;

$macro  PHI(t)    w_E(t)*(E_avg-E(t))/E_std \
                + w_delta*(delta_avg-delta)/delta_std \
                - w_h*(h_avg-h)/h_std \
                - w_l*(l_avg-l)/l_std \
                - w_y*(y_avg-y)/y_std

$macro  RHO(x) 1/(1+exp(-(x)))

$macro profit(t) ((E(t) - c(l))*Q(E(t))+ (delta-f(l,y,h)*K(delta) ))

$macro c(l)      (ci*(1-l)+l*cl)
$macro f(l,y,h)      (fi*(1-l)+l*fl+y*tau_f+mu*h)
$macro theta(l,h)  (theta0-eps_L*l+eps_h*h)
$macro Q(E)   (a-b*E)
$macro K(delta)   (K0-g*delta)



EQ_buyer..      z_buyer =e= sum(t,PHI(t))
;

EQ_norm(t).. w_E(t)+w_delta+w_y+w_l+w_h =e=1
;

EQ_profit.. z =e= sum(t,RHO(PHI(t))*profit(t))
;

EQ_caplim(t)..   Q(E(t))=l= theta(l,h)*(K0-g*delta)*8.760
;

EQ_q_pos(t).. Q(E(t)) =g= 0;


EQ_E_s(t)..     E(t)=l= E0   ;
EQ_delta_s..     delta =l= delta0;
EQ_l_s..         l =g= l0;
EQ_h_s..         h=g= h0;
EQ_y_s..         y =g= y0;

l.up = 1.0;
h.up = 1.0;
*y.up = 10;

Model buyer /
EQ_buyer,
*EQ_E_s,
*EQ_delta_s,
*EQ_l_s,
*EQ_h_s,
*EQ_y_s,
EQ_norm,
*EQ_q_pos
/;

model generator /
EQ_caplim,
EQ_profit,
*EQ_rho
/

model PPA /buyer generator/;

PPA.optfile=1;
PPA.savePoint=2;

file myinfo /'%emp.info%'/;
put myinfo 'bilevel w_E w_delta w_h w_l w_y';
put 'max z E delta h l y';
put 'EQ_profit EQ_caplim'
$ontext
put 'EQ_E_s EQ_delta_s EQ_h_s EQ_y_s EQ_l_s';
put 'dualvar w_E EQ_E_s ';
put 'dualvar w_delta EQ_delta_s ';
put 'dualvar w_h EQ_h_s ';
put 'dualvar w_y EQ_y_s ';
put 'dualvar w_l EQ_l_s ';
$offtext

*rho phi theta K Q c f
putclose / myinfo;



