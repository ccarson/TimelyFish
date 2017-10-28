 create procedure  PJARPAY_uRequeue  @parm1 varchar (6)  as
update PJARPAY
set status = '1'
from PJARPAY, ARDOC
where
PJARPAY.status =  '9' and
PJARPAY.check_refnbr = ARDOC.refnbr and
ARDOC.perpost = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJARPAY_uRequeue] TO [MSDSL]
    AS [dbo];

