
CREATE proc [dbo].[PJTran_BillMax_GetCreatedTrans0]
 @batnbr varchar(10) 

as 

select * from pjtran b

join pjtranex c
on c.fiscalno		= b.fiscalno
and c.system_cd		= b.system_cd
and c.batch_id		= b.batch_id
and c.detail_num	= b.detail_num

join batch d
on d.batnbr = b.batch_id
and d.module = b.system_cd
and d.module = 'PA'

where b.batch_id = @batnbr
and (b.tr_status = 'M1' or b.tr_status = 'M2')

order by b.detail_num


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTran_BillMax_GetCreatedTrans0] TO [MSDSL]
    AS [dbo];

