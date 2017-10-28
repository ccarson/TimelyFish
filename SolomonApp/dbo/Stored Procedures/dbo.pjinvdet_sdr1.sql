 Create Procedure pjinvdet_sdr1 @parm1 varchar (10)  as
select *
from pjinvdet
	left outer join pjemploy
		on pjinvdet.employee = pjemploy.employee
Where pjinvdet.draft_num = @PARM1  and
	pjinvdet.li_type <> 'S'
order by pjinvdet.acct,
	pjinvdet.project,
	pjinvdet.pjt_entity,
	pjinvdet.employee,
	pjinvdet.vendor_num,
	pjinvdet.source_trx_date



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvdet_sdr1] TO [MSDSL]
    AS [dbo];

