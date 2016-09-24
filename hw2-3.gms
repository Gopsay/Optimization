$Title Weasley's Wizard Wheezes- Maximizing the advertising campaign's audience reach

option limrow = 0, limcol = 0;

Set j    advertising mode                /TV, magazine,Radio/ ,
    i(j) subset when radio is not used   /TV,magazine/;
Parameters cost(j) Cost of each unit of the advertising mode used
           reach(j) Audience reach for each unit of the advertising mode used;

cost('TV') =  20000;
cost ('magazine') = 10000 ;

reach('TV') =  1800000  ;
reach('magazine') = 1000000  ;

positive variable Advt(i) Total units of each mode of advertising allocated when radio is not used
                  Adv(j)  Total units of each mode of advertising allocated ;
free variable Audience  The objective variable pertaining to total audience reached using the advertising campaign ;

*Fixing the lower bound for TV since 'one must sign up for atleast 10 minutes of TV'
Advt.lo('TV') = 10 ;

Equations AudienceReach The total audience reached through the advertising campaign is calculated
          TotalCost     The total budget available is 1 million galleons;

AudienceReach .. Audience =e= sum(i,reach(i)*Advt(i)) ;
TotalCost ..     sum(i,cost(i)*Advt(i)) =l= 1000000 ;

Model MaxReach1 /AudienceReach,TotalCost/ ;
Solve MaxReach1 using lp maximizing Audience ;
display MaxReach1.modelstat, MaxReach1.solvestat, MaxReach1.objval, Advt.l ;

parameters time(j) Time consumed for creating each type of advertising mode;
time('TV') =  1 ;
time('Magazine') = 3  ;

Equations TotalTime The total time available for the advertising campaign is 100 weeks;
TotalTime .. sum(i,time(i)*Advt(i)) =l= 100;

Model MaxReach2 /AudienceReach,TotalCost,TotalTime/ ;
Solve MaxReach2 using lp maximizing Audience ;
display MaxReach2.modelstat, MaxReach2.solvestat, MaxReach2.objval, Advt.l ;

cost('Radio') = 2000 ;
reach('Radio') = 250000 ;
time('Radio') = 1/7 ;

*Fixing the lower bound for TV since 'one must sign up for atleast 10 minutes of TV'
Adv.lo('TV') = 10;
Equations AudReach The total audience reached through the advertising campaign is calculated
          TotTime  The total time available for the advertising campaign is 100 weeks
          TotCost  The total budget available is 1 million galleons;
AudReach ..  Audience =e= sum(j,reach(j)*Adv(j)) ;
TotTime ..   sum(j,time(j)*Adv(j)) =l= 100;
TotCost ..   sum(j,cost(j)*Adv(j)) =l= 1000000 ;
Model MaxReach3 /AudReach,TotCost,TotTime/ ;
Solve MaxReach3 using lp maximizing Audience ;
display MaxReach3.modelstat, MaxReach3.solvestat, MaxReach3.objval, Adv.l ;

*Fixing the lower bound for Magazine since 'one must sign up for atleast 2 magazine pages'
Adv.lo('Magazine')=2;
*Fixing the upper bound for Radio since 'one can sign up for a maximum of 120 minutes of radio'
Adv.up('Radio')=120;

Model MaxReach4 /AudReach,TotCost,TotTime/ ;
Solve MaxReach4 using lp maximizing Audience ;
display MaxReach4.modelstat, MaxReach4.solvestat, MaxReach4.objval, Adv.l ;