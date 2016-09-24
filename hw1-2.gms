$Title Homework 01 Problem 02
$Ontext
Solving the following linear program in GAMS
$Offtext

option limrow = 0, limcol = 0;

set J    / 1, 2, 3 /;

free variable z "Decision Variable";

variable
x(J);
x.lo(J) = 0;
x.up(J) = 3;
equations
 obj        "Objective function",
 const1     "Constraint 1";

obj ..
z =e= 5*( x('1') + 2*x('2')) - 11*(x('2') - x('3')) ;

const1 ..
3*x('1') =g= sum((J),x(J)) ;

model prob2 /all/;

solve prob2 using lp maximizing z;

display x.l, x.lo, x.up, prob2.objval;
