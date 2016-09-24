$Title Pig Valve Production

$Ontext
US lab manufactures mechanical heart valves from the heart valves of pigs.
Different heart operations require valves of different sizes. US Labs purchases
pig valves from three different suppliers.

Each month, US labs places an order with each supplier. At least 500 large,
300 medium and 300 small valves must be purchased each month.
Due to limited availability of heart valves, at most 700 valves per month can be
purchased from each supplier.

The objecive is to acquire the needed pig valves while minimizing cost.

$Offtext
option limrow = 0, limcol = 0;
set suppliers    Suppliers /1*3/
    j            Size mix  /Large, Medium, Small/ ;

parameter cost(suppliers) Cost of a heart valve for each supplier
         / 1     5
           2     4
           3     3 /
          requirement(j) Heart valve requirements based on size mix
         / Large  500
           Medium 300
           Small  300 / ;

table PercentMix(suppliers,j) Percentage size mix of valves from each supplier
      Large Medium Small
1        40   40    20
2        30   35    35
3        20   20    60   ;

positive variable acquire(suppliers) Pig valve requirements for each supplier and product mix  ;
free variable z     Purchasing cost ;
equations
PurchasingCost                Purchasing cost of pig heart valves
SizeMixReq(j)                 Ensures adequate amount in each size mix is ordered
SizeMixBound(suppliers)       Ensures the purchasing quantity doesn't exceed supplier limitations ;

PurchasingCost..               z =e= sum(suppliers, cost(suppliers)*acquire(suppliers));
SizeMixReq(j)..                sum(suppliers,PercentMix(suppliers,j)*acquire(suppliers)/100) =g= requirement(j);
SizeMixBound(suppliers) ..     acquire(suppliers) =l= 700;

Model PVProduction /all/ ;
Solve PVProduction using lp minimizing z;
display PVProduction.Modelstat, PVProduction.Solvestat, PVProduction.objval, acquire.l;

