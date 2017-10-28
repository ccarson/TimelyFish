 Create Procedure pjinvdet_swipCCPT @parm1 varchar (10), @parm2 varchar (16) , @parm3 smalldatetime, @parm4 varchar (15)        as
select pjinvdet.*,
	pjpent.*,
	pjproj.*,
	pjemploy.employee, pjemploy.emp_name,
	vendor.vendid, vendor.name, pjacct.ca_id03
From pjinvdet
	left outer join pjpent
		on pjinvdet.project = pjpent.project
		and pjinvdet.pjt_entity = pjpent.pjt_entity
	left outer join pjproj
		on pjinvdet.project = pjproj.project
	left outer join pjemploy
		on pjinvdet.employee = pjemploy.employee
	left outer join vendor
		on pjinvdet.vendor_num = vendor.vendid
	left outer join pjacct
		on pjinvdet.acct = pjacct.acct
Where pjinvdet.in_id15 = @parm4 and
	pjinvdet.entry_type <> 'A' and
	(pjinvdet.draft_num = @PARM1 and pjinvdet.draft_num <> '' and
	pjinvdet.li_type in ('I','O'))
UNION
select pjinvdet.*,
	pjpent.*,
	pjproj.*,
	pjemploy.employee, pjemploy.emp_name,
	vendor.vendid, vendor.name, pjacct.ca_id03
From pjinvdet
	left outer join pjpent
		on pjinvdet.project = pjpent.project
		and pjinvdet.pjt_entity = pjpent.pjt_entity
	left outer join pjproj
		on pjinvdet.project = pjproj.project
	left outer join pjemploy
		on pjinvdet.employee = pjemploy.employee
	left outer join vendor
		on pjinvdet.vendor_num = vendor.vendid
	left outer join pjacct
		on pjinvdet.acct = pjacct.acct
Where pjinvdet.in_id15 = @parm4 and
	pjinvdet.entry_type <> 'A' and
	(pjinvdet.project_billwith = @PARM2 and
	pjinvdet.draft_num = ''  and
	pjinvdet.hold_status <> 'PG' and
	pjinvdet.source_trx_date <= @PARM3)
order by pjinvdet.acct, pjinvdet.project, pjinvdet.pjt_entity, pjinvdet.employee, pjinvdet.vendor_num, pjinvdet.source_trx_date



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvdet_swipCCPT] TO [MSDSL]
    AS [dbo];

