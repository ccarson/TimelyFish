 Create Procedure pjinvdet_spk3 @parm1 varchar (16)  as
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
	pjinvdet.draft_num = '0000000000'
order by pjinvdet.source_trx_id



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvdet_spk3] TO [MSDSL]
    AS [dbo];

