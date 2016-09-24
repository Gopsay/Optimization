$Title Alloy Bending Problem- HW 01 Problem 03

$Ontext

Steelco has deceived an order for 500 tonnes of steel to be used in shipbuilding.
The steel must adhere to either minimum or maximum grades for C, Cu & Mn.

The company has seven different raw materials in stock to be used.
We need to determine the composition of steel that minimizes the production cost.

$Offtext

option limrow = 0, limcol = 0;

Sets
 i Raw-material          /'Iron alloy 1', 'Iron alloy 2', 'Iron alloy 3',
                          'Copper 1', 'Copper 2', 'Aluminium 1', 'Aluminium 2'/
 j Chemical-elements     / Carbon, Copper, Manganese /;

Table ChemPerc(i,j) Percentage element for each raw material and each element
                 Carbon          Copper          Manganese
'Iron alloy 1'     2.5              0               1.3
'Iron alloy 2'     3                0               0.8
'Iron alloy 3'     0                0.3             0
'Copper 1'         0                90              0
'Copper 2'         0                96              4
'Aluminium 1'      0                0.4             1.2
'Aluminium 2'      0                0.6             0       ;

Parameters
 d(i)    Availability of each raw material in tonnes
         /'Iron alloy 1'     400
          'Iron alloy 2'     300
          'Iron alloy 3'     600
          'Copper 1'         500
          'Copper 2'         200
          'Aluminium 1'      300
          'Aluminium 2'      250 /

 e(i)    Cost of each raw material in dollars per tonnes
         /'Iron alloy 1'     200
          'Iron alloy 2'     250
          'Iron alloy 3'     150
          'Copper 1'         220
          'Copper 2'         240
          'Aluminium 1'      200
          'Aluminium 2'      165 /

 f(j)    Minimum grades in percentages
         /Carbon         2
          Copper         0.4
          Manganese      1.2  /

 g(j)    Maximum grades in percentages
         /Carbon         3
          Copper         0.6
          Manganese      1.65 /

free variable            z       Production cost;
positive variable        x(i)    Allocations of each raw material ;

equation
Cap(i)           Ensures that allocation of steel doesn't exceed raw material availability
MinCar(j)        Minimum grade for chemical elements
MaxCar(j)        Maximum grade for chemical elements
Totalalloc       The total allocation meets the requirements of the order recieved
Obj              Objective function minimizing production cost ;

Cap(i) ..        x(i) =l= d(i);

MinCar(j) ..     sum(i,x(i)*ChemPerc(i,j)) / 500 =g= f(j) ;

MaxCar(j) ..     sum(i,x(i)*ChemPerc(i,j)) / 500 =l= g(j) ;

Totalalloc ..    sum(i,x(i)) =e= 500 ;

Obj .. z =e=     sum(i,x(i)*e(i)) ;

Model prob3 /all/ ;

Solve prob3 using lp minimizing z;

parameter pct(j) "holds the final percentages";
* calculate and display the percentages
pct(j) = sum(i,x.l(i)* ChemPerc(i,j)) / 500 ;

display pct ;



