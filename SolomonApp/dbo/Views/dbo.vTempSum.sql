Create View vTempSum as 
Select RefNbr, DetailTypeID, Sum(Qty) as SumQty, sum(WgtCarc) as SumCarc, sum(WgtLive) as SumLive
from cftPSDetail
group by RefNbr, DetailTypeID
having count(*)>1
