 
create view pjdirutl as
select	a.employee employee,
		a.fiscalno fiscalno,
		round(sum(round(a.units,2)),2) units,
		round(sum(round(a.cost,2)),2) cost,
		round(sum(round(a.revenue,2)),2) revenue,
		round(sum(round(a.adjustments,2)),2) adjustments
from pjutlrol a, pjuttype b
where a.utilization_type = b.utilization_type
  and b.direct = "Y"
group by a.employee, a.fiscalno
	

 
