 

create view vi_08990SumCredits as

select v.custid, v.cpnyid, amount = sum(adjamt), discamt = sum(adjdiscamt), v.adjgperpost, v.updflag, 
FiscalYr = SUBSTRING(v.adjgperpost,1, 4), PerNbr = SUBSTRING(v.adjgperpost,5, 2)

from vi_08990SelectCredits v 

group by v.custid, v.cpnyid, v.adjgperpost, v.updflag


 
