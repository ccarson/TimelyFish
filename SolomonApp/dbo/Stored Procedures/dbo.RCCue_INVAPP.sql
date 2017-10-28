create Proc RCCue_INVAPP @parm1 varchar(10) as
select count(*)
from
PJINVHDR, PJEMPLOY, PJPROJ, CUSTOMER
where
PJEMPLOY.user_id  =  @parm1 AND
pjproj.project  =  pjinvhdr.project_billwith and
customer.custid =  pjinvhdr.customer and
pjinvhdr.approver_id = PJEMPLOY.employee and
pjinvhdr.inv_status = 'CO'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[RCCue_INVAPP] TO [MSDSL]
    AS [dbo];

