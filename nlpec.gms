*  MPEC written by GAMS Convert at 06/12/19 00:45:13
*  
*  Equation counts
*      Total        E        G        L        N        X        C        B
*          8        2        3        0        3        0        0        0
*  
*  Variable counts
*                   x        b        i      s1s      s2s       sc       si
*      Total     cont   binary  integer     sos1     sos2    scont     sint
*         12       12        0        0        0        0        0        0
*  FX      6        6        0        0        0        0        0        0
*  
*  Nonzero counts
*      Total    const       NL      DLL
*         74        8       66        0
*
*  Solve m using MPEC maximizing x1;

*
* WARNING: bounds on matched variables CANNOT BE CHANGED
*

* Reformulation parameters, after checking for consistency.
* Reform Type        SINGLE      DOUBLE
*  refType             mult        mult
*  slack           positive    positive
*  constraint      equality    equality
*  aggregate           none        none
*  NCPBounds           none        none



Variables  x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12;

Positive Variables  x2,x3,x7,x8,x9,x10,x11,x12;

Equations  e1,e2,e3,e4,e5,e6,e7,e8;
Positive Variable  S3 matches x12;
Positive Variable  S4 matches x2;
Positive Variable  S5 matches x3;

Scalars S    level value of function at current point
        SLO  min level for S   / 0 /
        SUP  min level for S   / +inf /
        muS  single bounded MU / 0.0 /
        muD  double bounded MU / 0.0 /;

* MUs will be reset just before the solve


e1.. -(0.783423863745777*x7*(14.271125 - x2) + 0.0475759144148892*x8*(235 - x3)
      - 14.9071198499986*x10*(0.75 - x5) - 12.9099444873581*x9*(0.2 - x4) - 
     0.782623792124926*x11*(4.28571428571429 - x6)) + x1 =E= 0;

e2..    x7 + x8 + x9 + x10 + x11 =E= 1;

e3.. (6.132 - 0.876*x4 + 0.876*x5)*(1.2 - 0.00102127659574468*x3)
      + 1.0626478998219*x2 =E= 12.981394944 + S3;

e4.. -((24.3198480350997 - 2.1252957996438*x2 + 2.64563905458993*x4)/(1 + exp(-
     (0.783423863745777*x7*(14.271125 - x2) + 0.0475759144148892*x8*(235 - x3)
      - 14.9071198499986*x10*(0.75 - x5) - 12.9099444873581*x9*(0.2 - x4) - 
     0.782623792124926*x11*(4.28571428571429 - x6)))) - 0.783423863745777*exp(-
     (0.783423863745777*x7*(14.271125 - x2) + 0.0475759144148892*x8*(235 - x3)
      - 14.9071198499986*x10*(0.75 - x5) - 12.9099444873581*x9*(0.2 - x4) - 
     0.782623792124926*x11*(4.28571428571429 - x6)))*x7/sqr(1 + exp(-(
     0.783423863745777*x7*(14.271125 - x2) + 0.0475759144148892*x8*(235 - x3)
      - 14.9071198499986*x10*(0.75 - x5) - 12.9099444873581*x9*(0.2 - x4) - 
     0.782623792124926*x11*(4.28571428571429 - x6))))*((-10.67 + x2 - 
     2.48966666666667*x4)*(12.981394944 - 1.0626478998219*x2) - (72.9 + 
     326.69696969697*x4 + 11.3939393939394*x5 + 1.70909090909091*x6)*(1.2 - 
     0.00102127659574468*x3) + x3)) - 1.0626478998219*x12 =E= 0 + S4;

e5.. (0.00626246808510638 - 0.00089463829787234*x4 + 0.00089463829787234*x5)*
     x12 - ((1.07445106382979 + 0.333647969052224*x4 + 0.0116363636363636*x5 + 
     0.00174545454545454*x6)/(1 + exp(-(0.783423863745777*x7*(14.271125 - x2)
      + 0.0475759144148892*x8*(235 - x3) - 14.9071198499986*x10*(0.75 - x5) - 
     12.9099444873581*x9*(0.2 - x4) - 0.782623792124926*x11*(4.28571428571429
      - x6)))) - 0.0475759144148892*exp(-(0.783423863745777*x7*(14.271125 - x2)
      + 0.0475759144148892*x8*(235 - x3) - 14.9071198499986*x10*(0.75 - x5) - 
     12.9099444873581*x9*(0.2 - x4) - 0.782623792124926*x11*(4.28571428571429
      - x6)))*x8/sqr(1 + exp(-(0.783423863745777*x7*(14.271125 - x2) + 
     0.0475759144148892*x8*(235 - x3) - 14.9071198499986*x10*(0.75 - x5) - 
     12.9099444873581*x9*(0.2 - x4) - 0.782623792124926*x11*(4.28571428571429
      - x6))))*((-10.67 + x2 - 2.48966666666667*x4)*(12.981394944 - 
     1.0626478998219*x2) - (72.9 + 326.69696969697*x4 + 11.3939393939394*x5 + 
     1.70909090909091*x6)*(1.2 - 0.00102127659574468*x3) + x3)) =E= 0 + S5;

e6.. (1.0512 - 0.00089463829787234*x3)*x12 - ((-424.355709915276 + 
     2.64563905458993*x2 + 0.333647969052224*x3)/(1 + exp(-(0.783423863745777*
     x7*(14.271125 - x2) + 0.0475759144148892*x8*(235 - x3) - 14.9071198499986*
     x10*(0.75 - x5) - 12.9099444873581*x9*(0.2 - x4) - 0.782623792124926*x11*(
     4.28571428571429 - x6)))) + 12.9099444873581*exp(-(0.783423863745777*x7*(
     14.271125 - x2) + 0.0475759144148892*x8*(235 - x3) - 14.9071198499986*x10*
     (0.75 - x5) - 12.9099444873581*x9*(0.2 - x4) - 0.782623792124926*x11*(
     4.28571428571429 - x6)))*x9/sqr(1 + exp(-(0.783423863745777*x7*(14.271125
      - x2) + 0.0475759144148892*x8*(235 - x3) - 14.9071198499986*x10*(0.75 - 
     x5) - 12.9099444873581*x9*(0.2 - x4) - 0.782623792124926*x11*(
     4.28571428571429 - x6))))*((-10.67 + x2 - 2.48966666666667*x4)*(
     12.981394944 - 1.0626478998219*x2) - (72.9 + 326.69696969697*x4 + 
     11.3939393939394*x5 + 1.70909090909091*x6)*(1.2 - 0.00102127659574468*x3)
      + x3)) =N= 0;

e7.. (-1.0512 + 0.00089463829787234*x3)*x12 - (14.9071198499986*exp(-(
     0.783423863745777*x7*(14.271125 - x2) + 0.0475759144148892*x8*(235 - x3)
      - 14.9071198499986*x10*(0.75 - x5) - 12.9099444873581*x9*(0.2 - x4) - 
     0.782623792124926*x11*(4.28571428571429 - x6)))*x10/sqr(1 + exp(-(
     0.783423863745777*x7*(14.271125 - x2) + 0.0475759144148892*x8*(235 - x3)
      - 14.9071198499986*x10*(0.75 - x5) - 12.9099444873581*x9*(0.2 - x4) - 
     0.782623792124926*x11*(4.28571428571429 - x6))))*((-10.67 + x2 - 
     2.48966666666667*x4)*(12.981394944 - 1.0626478998219*x2) - (72.9 + 
     326.69696969697*x4 + 11.3939393939394*x5 + 1.70909090909091*x6)*(1.2 - 
     0.00102127659574468*x3) + x3) - (13.6727272727273 - 0.0116363636363636*x3)
     /(1 + exp(-(0.783423863745777*x7*(14.271125 - x2) + 0.0475759144148892*x8*
     (235 - x3) - 14.9071198499986*x10*(0.75 - x5) - 12.9099444873581*x9*(0.2
      - x4) - 0.782623792124926*x11*(4.28571428571429 - x6))))) =N= 0;

e8.. -(0.782623792124926*exp(-(0.783423863745777*x7*(14.271125 - x2) + 
     0.0475759144148892*x8*(235 - x3) - 14.9071198499986*x10*(0.75 - x5) - 
     12.9099444873581*x9*(0.2 - x4) - 0.782623792124926*x11*(4.28571428571429
      - x6)))*x11/sqr(1 + exp(-(0.783423863745777*x7*(14.271125 - x2) + 
     0.0475759144148892*x8*(235 - x3) - 14.9071198499986*x10*(0.75 - x5) - 
     12.9099444873581*x9*(0.2 - x4) - 0.782623792124926*x11*(4.28571428571429
      - x6))))*((-10.67 + x2 - 2.48966666666667*x4)*(12.981394944 - 
     1.0626478998219*x2) - (72.9 + 326.69696969697*x4 + 11.3939393939394*x5 + 
     1.70909090909091*x6)*(1.2 - 0.00102127659574468*x3) + x3) - (
     2.05090909090909 - 0.00174545454545454*x3)/(1 + exp(-(0.783423863745777*x7
     *(14.271125 - x2) + 0.0475759144148892*x8*(235 - x3) - 14.9071198499986*
     x10*(0.75 - x5) - 12.9099444873581*x9*(0.2 - x4) - 0.782623792124926*x11*(
     4.28571428571429 - x6))))) =N= 0;

Equation CS3 matches x12;
   CS3.. S3*(x12 - 0) =E= muS ;
Equation CS4 matches x2;
   CS4.. S4*(x2 - 0) =E= muS ;
Equation CS5 matches x3;
   CS5.. S5*(x3 - 0) =E= muS ;

* set non default bounds

x4.fx = 0.3;
x5.fx = 0.75;
x6.fx = 5;
x9.fx = 0;
x10.fx = 0;
x11.fx = 0;

* touch all variables

x1.l = 0;
x2.l = 5.40453187621098;
x3.l = 88.9954359526372;
x4.l = 0.3;
x5.l = 0.75;
x6.l = 5;
x7.l = 0;
x8.l = 0;
x9.l = 0;
x10.l = 0;
x11.l = 0;
x12.l = 0;

S = (6.132 - 0.876*x4.l + 0.876*x5.l)*(1.2 - 0.00102127659574468*x3.l)
    + 1.0626478998219*x2.l - 12.981394944;
S3.L = max(SLO,S);
S = -((24.3198480350997 - 2.1252957996438*x2.l + 2.64563905458993*x4.l)/(1 + 
   exp(-(0.783423863745777*x7.l*(14.271125 - x2.l) + 0.0475759144148892*x8.l*(
   235 - x3.l) - 14.9071198499986*x10.l*(0.75 - x5.l) - 12.9099444873581*x9.l*(
   0.2 - x4.l) - 0.782623792124926*x11.l*(4.28571428571429 - x6.l)))) - 
   0.783423863745777*exp(-(0.783423863745777*x7.l*(14.271125 - x2.l) + 
   0.0475759144148892*x8.l*(235 - x3.l) - 14.9071198499986*x10.l*(0.75 - x5.l)
    - 12.9099444873581*x9.l*(0.2 - x4.l) - 0.782623792124926*x11.l*(
   4.28571428571429 - x6.l)))*x7.l/sqr(1 + exp(-(0.783423863745777*x7.l*(
   14.271125 - x2.l) + 0.0475759144148892*x8.l*(235 - x3.l) - 14.9071198499986*
   x10.l*(0.75 - x5.l) - 12.9099444873581*x9.l*(0.2 - x4.l) - 0.782623792124926
   *x11.l*(4.28571428571429 - x6.l))))*((-10.67 + x2.l - 2.48966666666667*x4.l)
   *(12.981394944 - 1.0626478998219*x2.l) - (72.9 + 326.69696969697*x4.l + 
   11.3939393939394*x5.l + 1.70909090909091*x6.l)*(1.2 - 0.00102127659574468*
   x3.l) + x3.l)) - 1.0626478998219*x12.l;
S4.L = max(SLO,S);
S = (0.00626246808510638 - 0.00089463829787234*x4.l + 0.00089463829787234*x5.l)
   *x12.l - ((1.07445106382979 + 0.333647969052224*x4.l + 0.0116363636363636*
   x5.l + 0.00174545454545454*x6.l)/(1 + exp(-(0.783423863745777*x7.l*(
   14.271125 - x2.l) + 0.0475759144148892*x8.l*(235 - x3.l) - 14.9071198499986*
   x10.l*(0.75 - x5.l) - 12.9099444873581*x9.l*(0.2 - x4.l) - 0.782623792124926
   *x11.l*(4.28571428571429 - x6.l)))) - 0.0475759144148892*exp(-(
   0.783423863745777*x7.l*(14.271125 - x2.l) + 0.0475759144148892*x8.l*(235 - 
   x3.l) - 14.9071198499986*x10.l*(0.75 - x5.l) - 12.9099444873581*x9.l*(0.2 - 
   x4.l) - 0.782623792124926*x11.l*(4.28571428571429 - x6.l)))*x8.l/sqr(1 + 
   exp(-(0.783423863745777*x7.l*(14.271125 - x2.l) + 0.0475759144148892*x8.l*(
   235 - x3.l) - 14.9071198499986*x10.l*(0.75 - x5.l) - 12.9099444873581*x9.l*(
   0.2 - x4.l) - 0.782623792124926*x11.l*(4.28571428571429 - x6.l))))*((-10.67
    + x2.l - 2.48966666666667*x4.l)*(12.981394944 - 1.0626478998219*x2.l) - (
   72.9 + 326.69696969697*x4.l + 11.3939393939394*x5.l + 1.70909090909091*x6.l)
   *(1.2 - 0.00102127659574468*x3.l) + x3.l));
S5.L = max(SLO,S);

* set non default marginals


Model m / all /;

m.limrow=0; m.limcol=0;

m.optfile    = 0;

option DNLP=CONOPT;

muS = 0;
muD = 0;

Solve m using DNLP maximizing x1;
