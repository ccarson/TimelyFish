 Create Procedure pjinvdet_sdr0 @parm1 varchar (10)  as
select *
From pjinvdet
	left outer join pjemploy
		on pjinvdet.employee = pjemploy.employee
Where pjinvdet.draft_num = @PARM1 and
	pjinvdet.li_type <> 'S'
order by pjinvdet.acct,
	pjinvdet.labor_class_cd,
	pjinvdet.employee,
	pjinvdet.vendor_num,
	pjinvdet.source_trx_date



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvdet_sdr0] TO [MSDSL]
    AS [dbo];

