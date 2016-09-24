$Title Manufacturing Transistors

$Ontext

Silicon Valley Corporation (Silvco) manufactures transistors. An important aspect
of the manfuacturing process is the melting of the element germanium in a furnace.
Unfortunately, the melting process yields germanium of highly variable quality.
The results of the process can be classified into five grades:
Defective, grade 1, grade 2, grade 3, grade 4. Two methods can be used to do the melting.
Method 1 costs $50 per transister, method 2 costs $70 per transistor.

Silvco can refire melted germanium in an attempt to improve its quality.
It costs $25 to refire the melted germanium for one transistor. Only one stage
of refiring is allowed. The goal is to model the melting/refiring process
and determine the minimum cost of germanium processing required to meet the demands.

$Offtext
option limrow = 0, limcol = 0;
Sets
i  Silicon obtained /defective, grade1, grade2, grade3, grade4/
j  Method used      /method1, method2/
k  Silicon refired  /defective, grade1, grade2, grade3, grade4/ ;

parameter meltingcost(j) Cost of melting for different methods
   /method1        50
    method2        70/ ;

Table
melting(i,j) Qualities of germanium produced by melting (given as percentage yields)
         method1 method2
defective 30     20
grade1    30     20
grade2    20     25
grade3    15     20
grade4     5     15      ;

Table
refiring(i,k) Qualities of germanium produced by refiring (given as percentage yields)
         defective grade1 grade2 grade3 grade4
defective   30      25      15     20      10
grade1       0      30      30     20      20
grade2       0       0      40     30      30
grade3       0       0       0     50      50   ;

positive variable melt(j)     Total transistors that are melt using method 1 or 2 ,
                  refire(j,i) Total transistors that are refired   ;
free variable processingcost  Total cost of processing germanium;

Equations
CostofProcessing      Total processing cost of germanium which needs to be minimized
DemandGrade1          Monthly demand for Grade 1 transistors
DemandGrade2          Monthly demand for Grade 2 transistors
DemandGrade3          Monthly demand for Grade 3 transistors
DemandGrade4          Monthly demand for Grade 4 transistors
MaxRefireAllowed(j,i) The number of transistors refired cannot exceed the number of transistors melted
TotalTransistors      Total number of transistors used in melting and refiring cannot exceed 20000 ;

CostofProcessing ..      processingcost =e= sum(j,meltingcost(j)*melt(j)) + sum((j,i),refire(j,i))*25 ;
DemandGrade4 ..          sum(j,(melting('grade4', j)/100 * melt(j)) )+ sum((j,i), refire(j,i)*refiring(i, 'grade4')/100) =g= 1000;
DemandGrade3 ..          sum(j,(melting('grade3', j)/100 * melt(j)) -refire(j,'grade3' ) ) + sum((j,i), refire(j,i)*refiring(i, 'grade3')/100) =g= 2000;
DemandGrade2 ..          sum(j,(melting('grade2', j)/100 * melt(j)) -refire(j,'grade2' ) ) + sum((j,i), refire(j,i)*refiring(i, 'grade2')/100) =g= 3000;
DemandGrade1 ..          sum(j,(melting('grade1', j)/100 * melt(j)) -refire(j,'grade1' ) ) + sum((j,i), refire(j,i)*refiring(i, 'grade1')/100) =g= 3000;
MaxRefireAllowed(j,i) .. melting(i,j)*melt(j)/100 =g= refire(j,i)  ;
TotalTransistors ..      sum(j,melt(j)) + sum((j,i),refire(j,i)) =l= 20000;

model SilvcoCost /all/ ;
solve SilvcoCost using lp minimizing processingcost ;

display SilvcoCost.modelstat, SilvcoCost.solvestat, SilvcoCost.objval, melt.l, refire.l ;