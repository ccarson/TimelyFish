﻿CREATE proc [dbo].[PJTran_Trans_Reversal0]
 @batnbr varchar(10)
as 
	
select 
	 *
from 
	PJTrnsfr a join PJTran b 
on
     a.Origfiscalno = b.fiscalno and
     a.Origsystem_cd = b.system_cd and
     a.Origbatch_id = b.batch_id and
     a.Origdetail_num = b.detail_num
join
	 Batch c 
on
	 a.batch_id = c.batnbr and 
	 c.module = 'PA'
join
	pjtranex e
on
	b.fiscalno		= e.fiscalno and
    b.system_cd		= e.system_cd and
    b.batch_id		= e.batch_id and
    b.detail_num	= e.detail_num
where
	 c.batnbr = @batnbr and
	 c.module = 'PA'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTran_Trans_Reversal0] TO [MSDSL]
    AS [dbo];

