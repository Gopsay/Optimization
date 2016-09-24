$Title Homework 01 Problem 01
$Ontext
Solving the following linear program in GAMS
$Offtext

  option limrow = 0, limcol = 0;

  free variable z "Decision Variable";

  positive variable x1, x2, x3;

  equations
  obj        "Objective function",
  const1     "Constraint 1",
  const2     "Constraint 2",
  const3     "Constraint 3";

  obj..
   z =e= 3*x1 + 2*x2 - 33*x3;

  const1..
  1*x1 - 4*x2 + 1*x3 =l= 15;

  const2..
  9*x1 + 6*x3 =e= 12;

  const3..
  -5*x1 + 9*x2 =g= 3;

 model prob1 /all/;

 solve prob1 using lp minimizing z;

 parameter x1val, x2val, x3val, objval;
 objval = z.l ;
 x1val = x1.l ;
 x2val = x2.l ;
 x3val = x3.l ;
 display objval, x1val, x2val, x3val ;



