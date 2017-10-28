
CREATE proc [dbo].[PJALLAUD_Update]
 @batnbr varchar(10)
as 

Update 
	pjallaud
set 
	recalc_flag = 'Y'
from 
	PJAllAud d join PJTrnsfr a on
    a.Origfiscalno = d.fiscalno and
    a.Origsystem_cd = d.system_cd and
    a.Origbatch_id = d.batch_id and
    a.Origdetail_num = d.detail_num 
Where
	a.batch_id = @batnbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJALLAUD_Update] TO [MSDSL]
    AS [dbo];

