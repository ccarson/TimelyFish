 
create view pjutlgol as
select
'empcode' = case when pjutgoal.hours_goal is null then b.employee
			else a.employee end,
'fiscalno' = case when pjutgoal.hours_goal is null then pjdirutl.fiscalno
			else pjutgoal.fiscalno end,
'hrs' = case when pjutgoal.hours_goal is null then 0.00
			else pjutgoal.hours_goal end,
'revgoal' = case when pjutgoal.revenue_goal is null then 0.00
			else pjutgoal.revenue_goal end,
'units' = case when pjdirutl.units is null then 0.00
			else pjdirutl.units end,
'cost' = case when pjdirutl.cost is null then 0.00
			else pjdirutl.cost end,
'revenue' = case when pjdirutl.revenue is null then 0.00
			else pjdirutl.revenue end,
'adjustments' = case when pjdirutl.adjustments is null then 0.00
			else pjdirutl.adjustments end,
'empname' = case when pjutgoal.hours_goal is null then b.emp_name
			else a.emp_name end,
'empstatus' = case when pjutgoal.hours_goal is null then b.emp_status
			else a.emp_status end,
'emptype' = case when pjutgoal.hours_goal is null then b.emp_type_cd
			else a.emp_type_cd end,
'manager1' = case when pjutgoal.hours_goal is null then b.manager1
			else a.manager1 end,
'manager2' = case when pjutgoal.hours_goal is null then b.manager2
			else a.manager2 end,
'gl_subacct' = case when pjutgoal.hours_goal is null then b.gl_subacct
			else a.gl_subacct end,
'cpnyid' = case when pjutgoal.hours_goal is null then b.cpnyid
			else a.cpnyid end
from pjutgoal full join pjdirutl
on pjutgoal.employee = pjdirutl.employee
and pjutgoal.fiscalno = pjdirutl.fiscalno
left join pjemploy a on pjutgoal.employee = a.employee
left join pjemploy b on pjdirutl.employee = b.employee
	

 
