$Title Tree Planting problem. Homework 01 Problem 04.

$Ontext
A forestry company has four sites on which they grow trees. They re considerig four
species of trees, the pines, spruces, walnuts and other hardwoods.

The objective is to maximize the expected annual revenue

$Offtext

option limrow = 0, limcol = 0 ;

Sets
i      Sites             /1*4/
j      Species of trees  /Pine,Spruce,Walnut,Hardwood/

Table yield(i,j)  Expected annual yield in 1000 cubic metre per ka
          Pine       Spruce      Walnut        Hardwood
      1   17           14          10            9
      2   15           16          12           11
      3   13           12          14            8
      4   10           11           8            6    ;

Table revenue(i,j)  Expected annual revenue in money units per ka
          Pine       Spruce      Walnut        Hardwood
      1   16           12          20           18
      2   14           13          24           20
      3   17           10          28           20
      4   12           11          18           17    ;

positive Variable x(i,j)  area allocations for each site and each species of tree  ;
free variable     z       total expected annual revenue ;

parameters
a(j)     Minimum required yield
         / Pine          22.5
           Spruce        9
           Walnut        4.8
           Hardwood      3.5 /
b(i)     Maximum area available
          / 1            1500
            2            1700
            3            900
            4            600 / ;
Equations
ExpYield(j)    The yield of each species of tree must meet the minimum yield requirements
Area(i)        The total area allocated cannot exceed the total area available
Objective      The objective function that maximizes the revenue ;

Objective ..   z =e= sum((i,j), x(i,j)*revenue(i,j))    ;
ExpYield(j) .. sum(i, x(i,j)*yield(i,j) / 1000) =g= a(j) ;
Area(i) ..     sum(j, x(i,j)) =l= b(i) ;

Model treeplanting /all/ ;

Solve treeplanting using lp maximizing z;

display x.l;
