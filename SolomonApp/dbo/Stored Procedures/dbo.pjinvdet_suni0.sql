 Create Procedure pjinvdet_suni0 @parm1 varchar (16)  as
select *
from pjinvdet
	left outer join pjemploy
		on 	pjinvdet.employee = pjemploy.employee
Where pjinvdet.project_billwith = @PARM1 and
	pjinvdet.bill_status = 'U'
order by pjinvdet.acct,
	pjinvdet.labor_class_cd,
	pjinvdet.employee,
	pjinvdet.vendor_num,
	pjinvdet.source_trx_date



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvdet_suni0] TO [MSDSL]
    AS [dbo];

