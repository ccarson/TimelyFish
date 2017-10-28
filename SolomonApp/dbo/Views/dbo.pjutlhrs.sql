 
create view pjutlhrs as
select
'empcode' = case when pjutgoal.hours_goal is null then b.employee
			else a.employee end,
'fiscalno' = case when pjutgoal.hours_goal is null then pjsumhrs.fiscalno
			else pjutgoal.fiscalno end,
'directhrs' = case when pjsumhrs.directhrs is null then 0.00
               else pjsumhrs.directhrs end,
'indirecthrs' = case when pjsumhrs.indirecthrs is null then 0.00
               else pjsumhrs.indirecthrs end,
'availhrs' = case when pjutgoal.available_hours is null then 0.00
			else pjutgoal.available_hours end,
'goalhrs' = case when pjutgoal.hours_goal  is null then 0.00
			else pjutgoal.hours_goal  end,
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
from pjutgoal full join pjsumhrs
on pjutgoal.employee = pjsumhrs.employee
and pjutgoal.fiscalno = pjsumhrs.fiscalno
left join pjemploy a on pjutgoal.employee = a.employee
left join pjemploy b on pjsumhrs.employee = b.employee
	

 
