 

CREATE VIEW vi_08990CompCustBal AS

Select 
a.cpnyid, a.custid, 
NewCurrentBal = (sum(v.currbal * v.balmul)),
NewFutureBal = (sum(v.futurebal * v.balmul)),
OldCurrentBal = min(a.currbal),
OldFutureBal = min(a.futurebal)
from ar_balances a left join vi_08990CustBalDocs v on v.cpnyid = a.cpnyid and v.custid = a.custid
group by a.cpnyid, a.custid


 
