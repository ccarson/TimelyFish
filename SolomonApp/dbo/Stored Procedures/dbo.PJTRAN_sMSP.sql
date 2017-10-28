create procedure PJTRAN_sMSP 
	@project varchar (16), 
	@task varchar (32), 
	@TranDate smalldatetime,
	@employee varchar (10),
	@subTask varchar (50)
as
Select 
	ROUND(SUM(ROUND(UNITS,2)),2), 
	ROUND(SUM(ROUND(AMOUNT,2)),2) 
from 
PJTRAN t inner join pjacct a on t.acct = a.acct

where
	project = @project and
	pjt_entity = @task and
	trans_date = @TranDate and
	employee = @employee and
	subtask_name = @subTask and
	a.ca_id20 = 'W'

GROUP BY 
project, pjt_entity, trans_date, employee, subtask_name
order BY 
project, pjt_entity, trans_date, employee, subtask_name

