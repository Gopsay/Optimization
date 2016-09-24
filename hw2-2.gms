$Title Bussville-Assignment of student population in districts to the schools

option limrow = 0, limcol = 0;
set i    Districts /District1*District3/
    j    Schools   /Cooley, Whitman/
    k    Students  /Minority, Non-Minority/ ;

Table
studentpop(i,k)  Student population in each district for each type of minority
               Minority   Non-Minority
District1         50          200
District2         50          250
District3        100          150    ;

Table
distance(i,j)   Distance matrix to travel from each district to each school in miles
                Cooley       Whitman
District1         1.2          1.8
District2         2.2          0.9
District3         1.4          0.8   ;

positive variable x(i,j,k)  Students assigned for each school from each district and minority status;
free variable totaldistance The distance function for total distance which will be minimized ;

Equations
ObjTotalDistance       The objective function for total distance travelled in miles
MinStrength(j)         Each school should have a minimum enrollment of 350 students
MaxStrength(j)         Each school should have a maximum enrollment of 500 students
SchoolMinority1        Difference between the Minority population of the schools is not less than 5% of total minority population
SchoolMinority2        Difference between the Minority population of the schools is not less than 5% of total minority population
AllAttendSchool(i,k)   school population constraint;


ObjTotalDistance ..        totaldistance =e= sum((i,j,k),distance(i,j)*x(i,j,k)) ;
MinStrength(j) ..          sum((i,k),x(i,j,k)) =g= 350 ;
MaxStrength(j) ..          sum((i,k),x(i,j,k)) =l= 500 ;
SchoolMinority1 ..         sum(i, x(i,'Whitman','Minority'))-sum(i,x(i,'Cooley','Minority')) =l= 0.05*sum((i,j),x(i,j,'Minority'));
SchoolMinority2 ..         sum(i, x(i,'Cooley','Minority'))-sum(i,x(i,'Whitman','Minority')) =l= 0.05*sum((i,j),x(i,j,'Minority'));
AllAttendSchool(i,k) ..    sum(j,x(i,j,k)) =e= studentpop(i,k);


Model Bussville /all/ ;
Solve Bussville using lp minimizing totaldistance;

display Bussville.modelstat, Bussville.solvestat, Bussville.objval, x.l ;


