Create View vTemp as
Select RefNbr, DetailTypeID, Count(*) as Nbr
from cftPSDetail 
group by RefNbr, DetailTypeID
having Count(*)>1
