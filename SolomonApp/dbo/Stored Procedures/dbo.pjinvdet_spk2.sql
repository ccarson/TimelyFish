 Create Procedure pjinvdet_spk2 @parm1 varchar (10)  as
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
Where pjinvdet.draft_num = @PARM1 and
	pjinvdet.li_type <> 'S'
order by pjinvdet.draft_num, pjinvdet.source_trx_date



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvdet_spk2] TO [MSDSL]
    AS [dbo];

