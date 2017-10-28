 Create Procedure pjinvdet_sdr3 @parm1 varchar (10)  as
select *
from pjinvdet
	left outer join pjemploy
		on pjinvdet.employee = pjemploy.employee
Where pjinvdet.draft_num = @PARM1  and
	pjinvdet.li_type <> 'S'
order by pjinvdet.project,
	pjinvdet.pjt_entity,
	pjinvdet.acct,
	pjinvdet.employee,
	pjinvdet.vendor_num,
	pjinvdet.source_trx_date



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvdet_sdr3] TO [MSDSL]
    AS [dbo];

