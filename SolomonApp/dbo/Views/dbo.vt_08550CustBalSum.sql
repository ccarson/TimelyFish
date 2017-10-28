 

Create view vt_08550CustBalSum as

Select 

a.custid, 
LastActDate = max(a.LastActDate),
TotFutureBal = sum(a.FutureBal),
TotCurrBal = sum(a.CurrBal)

from ar_balances a 
group by a.custid




 
