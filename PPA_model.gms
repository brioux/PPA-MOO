option nlp=pathnlp;

Variables z,z_buyer,P(t),delta,l,h,y ;
Positive variables
      P,delta,l,
      h,y,
      w_P(t)            weight on energy price target
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
EQ_P_s(t)
EQ_delta_s
EQ_l_s
eq_5_5(t)
Eq_5_6(t)
EQ_h_s
EQ_y_s
EQ_norm
EQ_q_pos(t)  generator production shold be non-negative
;

$macro  PHI(t)    w_P(t)*(P_avg-P(t))/P_std \
                + w_delta*(delta_avg-delta)/delta_std \
                - w_h*(h_avg-h)/h_std \
                - w_l*(l_avg-l)/l_std \
                - w_y*(y_avg-y)/y_std

$macro  RHO(x) 1/(1+exp(-(x)))

$macro profit(t) ((P(t) - c(l))*Q(P(t))+ (delta-f(l,y,h)*K(delta) ))

$macro c(l)      (ci*(1-l)+l*cl)
$macro f(l,y,h)      (fi*(1-l)+l*fl+y*tau_f+mu*h)
$macro theta(l,h)  (theta0-eps_L*l+eps_h*h)
$macro Q(P)   (a-b*P)
$macro K(delta)   (K0-g*delta)



EQ_buyer..      z_buyer =e= sum(t,PHI(t))
;

EQ_norm(t).. w_P(t)+w_delta+w_y+w_l+w_h =e=1
;

EQ_profit.. z =e= sum(t,RHO(PHI(t))*profit(t))
;

EQ_caplim(t)..   Q(P(t))=l= theta(l,h)*(K0-g*delta)*8.760
;

EQ_q_pos(t).. Q(P(t)) =g= 0;


EQ_P_s(t)..     P(t)=l= P0   ;
EQ_delta_s..     delta =l= delta0;
EQ_l_s..         l =g= l0;
EQ_h_s..         h=g= h0;
EQ_y_s..         y =g= y0;

l.up = 1.0;
h.up = 1.0;
*y.up = 10;

Model buyer /
EQ_buyer,
*EQ_P_s,
*EQ_delta_s,
*EQ_l_s,
*EQ_h_s,
*EQ_y_s,
EQ_norm,
/;

model generator /
EQ_caplim,
EQ_profit,
*EQ_q_pos
/

model PPA /buyer generator/;

PPA.optfile=1;
PPA.savePoint=2;

file myinfo /'%emp.info%'/;
put myinfo 'bilevel w_P w_delta w_h w_l w_y';
put 'max z P delta h l y ';
put 'EQ_profit EQ_caplim'
$ontext
put 'EQ_P_s EQ_delta_s EQ_h_s EQ_y_s EQ_l_s';
put 'dualvar w_P EQ_P_s ';
put 'dualvar w_delta EQ_delta_s ';
put 'dualvar w_h EQ_h_s ';
put 'dualvar w_y EQ_y_s ';
put 'dualvar w_l EQ_l_s ';
$offtext

*rho phi theta K Q c f
putclose / myinfo;



