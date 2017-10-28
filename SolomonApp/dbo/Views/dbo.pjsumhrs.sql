 
create view pjsumhrs as
select	employee,
		fiscalno,
	round(sum(round(directhrs,2)),2) directhrs,
	round(sum(round(indirecthrs,2)),2) indirecthrs
from pjallutl
group by employee, fiscalno  
	

 
