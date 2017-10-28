 Create Procedure pjinvdet_spk1 @parm1 varchar (16) , @parm2 smalldatetime  as
select  pjinvdet.*,
	pjpent.*,
	pjproj.*,
	pjemploy.employee, pjemploy.emp_name
From pjinvdet
	left outer join pjpent
		on pjinvdet.project = pjpent.project
		and pjinvdet.pjt_entity = pjpent.pjt_entity
	left outer join pjproj
		on pjinvdet.project = pjproj.project
	left outer join pjemploy
		on pjinvdet.employee = pjemploy.employee
Where pjinvdet.project_billwith = @PARM1 and
	pjinvdet.draft_num = ''  and
	pjinvdet.hold_status <> 'PG' and
	pjinvdet.source_trx_date <= @PARM2
order by pjinvdet.draft_num, pjinvdet.source_trx_date



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvdet_spk1] TO [MSDSL]
    AS [dbo];

