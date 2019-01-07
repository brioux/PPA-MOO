option nlp=pathnlp;

Variables z,z_buyer,E(t),Q(t),delta,c(t),f(t),l,K,theta(t),h,y ;
Positive variables
      E,Q,delta,f,c,l,K,theta,
      h,y,
      w_E(t)            weight on energy price target
      w_delta           weight on capacity price target
      w_l               weight on local content target
      w_h               weight on financial warranties
      w_y               weight on years of experience
      rho(t)
      phi(t)
      w_total
;

Equations
EQ_profit         "generator's profit"
EQ_theta(t)       utiliazation factor
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

* Identities
EQ_rho(t)         bid response function
EQ_phi(t)         bid ranking function
EQ_Q(t)           quantity of energy generated
EQ_K              quantity of capacity supplied
EQ_costv(t)       variable produciton cost
EQ_costf(t)       fixed productino cost
;


EQ_caplim(t)..       a-b*E(t) =l= (theta0 - eps_L*l +eps_h*h)*K*8.760;

EQ_profit..     z =e= sum(t,
*                        rho(t)*
*$ontext
  1/(1+exp(-(
         +w_E(t)*(E_avg-E(t))/E_std
*(1$(E_avg>E0)-1$(E_avg<=E0))
        +w_delta*(delta_avg-delta)/delta_std
*(1$(delta_avg>delta0)-1$(delta_avg<=delta0))
        -w_h*(h_avg-h)/h_std
*(1$(h_avg>h0)-1$(h_avg<=h0))
        -w_l*(l_avg-l)/l_std
*(1$(l_avg>l0)-1$(l_avg<=l0))
        -w_y*(y_avg-y)/y_std
*(1$(y_avg>y0)-1$(y_avg<=y0))
        )))*
  (
*   (E(t) - c(t))*Q(t) + (delta-f(t))*K
    (E(t) - (ci*(1-l) + l*cl))*(a-b*E(t))+ (delta-(fi*(1-l) + l*fl+y*tau_f+v*h))*(K0-g*delta)
  )
*$offtext
                  )
;

EQ_buyer..      z_buyer =e=
                        (w_delta*(delta0-delta)/delta0)$(delta0>0)
                        +sum(t,w_E(t)*(E0-E(t)))/E0
                        +w_l*(l-l0)/l0
                        +w_h*(h-h0)/h0
                        +w_y*(y-y0)/y0
;

EQ_E_s(t)..     E(t)=l= E0   ;
EQ_delta_s..     delta =l= delta0;
EQ_l_s..         -l =l= -l0;
EQ_h_s..         -h=l= -h0;
EQ_y_s..         -y =l= -y0;

EQ_norm(t).. w_y+w_l+w_E(t)+w_delta+w_h =e=1;

EQ_rho(t).. rho(t) =e= 1/(1+exp(-phi(t)));

EQ_phi(t).. phi(t) =e=   w_E(t)*(E_avg-E(t))/E_std
                        +w_delta*(delta_avg-delta)/delta_std
                        -w_h*(h_avg-h)/h_std
                        -w_l*(l_avg-l)/l_std
                        -w_y*(y_avg-y)/y_std
;

EQ_costv(t)..     c(t) =e= ci*(1-l) + l*cl;
EQ_costf(t)..     f(t) =e= fi*(1-l) + l*fl+y*tau_f+v*h;
EQ_theta(t)..     theta(t) =e= theta0 - eps_L*l +eps_h*h;
EQ_Q(t)..         Q(t) =e= a-b*E(t);
EQ_K..            K =e= K0-g*delta;

l.up = 1.0;
h.up = 1.0;
y.up = 10;

*w_delta.lo = 0.1;
*w_y.lo = 0.1;

Model buyer /
EQ_buyer,
EQ_E_s,
EQ_delta_s,
EQ_l_s,
EQ_h_s,
EQ_y_s,
EQ_norm,
/;

model generator /
EQ_caplim,
EQ_profit,

* these are identities calculated post solve
*EQ_costv,
*EQ_costf,
*EQ_theta,
*EQ_K,
*EQ_Q
/

model PPA /buyer generator/;

PPA.optfile=1;
PPA.savePoint=2;

file myinfo /'%emp.info%'/;
put myinfo 'bilevel w_E w_delta w_h w_y w_l';
put 'max z E delta h y l';
put 'EQ_profit EQ_caplim '
$ontext
put 'EQ_E_s EQ_delta_s EQ_h_s EQ_y_s EQ_l_s';
put 'dualvar w_E EQ_E_s ';
put 'dualvar w_delta EQ_delta_s ';
put 'dualvar w_h EQ_h_s ';
put 'dualvar w_y EQ_y_s ';
put 'dualvar w_l EQ_l_s ';
$offtext

*EQ_K EQ_costf EQ_costv EQ_theta
*rho phi theta K Q c f
putclose / myinfo;



