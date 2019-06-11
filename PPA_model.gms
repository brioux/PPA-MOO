option nlp=pathnlp
;

Variables z,z_buyer,P(t),delta,l,h,y
      zeta(t)              dual variable on the capacity constraint 
;
Positive variables
      P,delta,
      l,h,y,
      w_P(t)            weight on energy price target
      w_delta           weight on capacity price target
      w_l               weight on local content target
      w_h               weight on financial warranties
      w_y               weight on years of experience
      zeta(t)           dual variable on the capacity constraint      
;

Equations
EQ_profit         "generator's profit"
EQ_caplim(t)      generators capacity limit constraint

EQ_buyer
EQ_norm

EQ_opt_delta(t)
EQ_opt_p(t)
EQ_opt_capacity(t)
;

$macro  PHI(t)    w_P(t)*(P_avg-P(t))/P_std \
                + w_delta*(delta_avg-delta)/delta_std \
                - w_h*(h_avg-h)/h_std \
                - w_l*(l_avg-l)/l_std \
                - w_y*(y_avg-y)/y_std

$macro RHO(x) 1/(1+exp(-(x)))

$macro profit(t) ((P(t) - c(l))*Q(P(t))+ (delta-f(l,y,h)*K(delta) ))

$macro c(l)      (ci*(1-l)+l*cl)
$macro f(l,y,h)      (fi*(1-l)+l*fl+y*tau_f+mu*h)
* compute generation in MWh by multiplying  capacity (Kw) by 8760 hours divided by 1000
* see EQ_caplim below
$macro theta(l,h)  (theta0-eps_L*l+eps_h*h)*8.76 
$macro Q(P) (a-b*P)
$macro K(delta) (K0-g*delta)


$macro delta_opt(l,h) ((Q(P_avg)-theta(l,h)*K0)*delta_std+b*delta_avg*P_std)/(b*P_std-g*theta(l,h)*delta_std)
$macro P_opt(l,h) (-g*theta(l,h)*P_avg*delta_std+(a-K0*theta(l,h)+g*theta(l,h)*delta_avg)*P_std)/(b*P_std-g*theta(l,h)*delta_std)
$macro nu(l,h) (a-b*P_avg-K0*theta(l,h)+g*theta(l,h)*delta_avg)/(b*P_std-g*theta(l,h)*delta_std)
$macro h_opt h_avg-h_std*(a-b*P_avg-theta0*K0+theta0*g*delta_avg)/(b*P_std-g*theta0*delta_std)
$macro l_opt l_avg-l_std*(a-b*P_avg-theta0*K0+theta0*g*delta_avg)/(b*P_std-g*theta0*delta_std)
$macro y_opt y_avg-y_std*(a-b*P_avg-theta0*K0+theta0*g*delta_avg)/(b*P_std-g*theta0*delta_std)

EQ_buyer..      z_buyer =e= sum(t,PHI(t))
;

EQ_norm(t).. w_P(t)+w_delta+w_y+w_l+w_h =e=1
;

EQ_profit.. z =e= sum(t,RHO(PHI(t))*profit(t))
;

EQ_caplim(t)..   Q(P(t)) =l=  theta(l,h)*k(delta)
;

EQ_opt_delta(t).. (k0 - 2*delta*g + g*f(l,y,h))/(1+exp(-PHI(t)))
        -w_delta*exp(-PHI(t))*profit(t)/(delta_std*(1+exp(-PHI(t)))**2)
        -g*theta(l,h)*zeta(t) =g= 0
;

EQ_opt_p(t).. (a+b*c(l)-2*b*P(t))/(1+exp(-PHI(t)))
  -w_P(t)*exp(-PHI(t))*profit(t)/(P_std*(1+exp(-PHI(t)))**2)
  +b*zeta(t) =g= 0
;

EQ_opt_capacity(t).. Q(P(t)) - theta(l,h)*K(delta) =e= 0
;

l.up = 1.0;
h.up = 1.0;
*y.up = 10;

Model buyer /
EQ_buyer,
EQ_norm
/;

* below is the buyers problem with the generators optimality conditions
Model buyer_gen_opt  /
buyer,
EQ_caplim,
EQ_opt_delta,
EQ_opt_p,
*EQ_opt_capacity
/;


model generator /
EQ_caplim,
EQ_profit
/

model PPA /buyer generator/;

*PPA.optfile=1;
PPA.savePoint=2;





