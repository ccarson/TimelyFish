
CREATE proc [dbo].[PJTran_BillMax_Reversal1]
 @batnbr varchar(10), 
 @project varchar(16), 
 @maxacct varchar(16), 
 @addlacct varchar(16)

as 

select * from pjtran b

join pjtranex c
on c.fiscalno		= b.fiscalno
and c.system_cd		= b.system_cd
and c.batch_id		= b.batch_id
and c.detail_num	= b.detail_num

join batch d
on d.batnbr = b.batch_id
and d.module = 'PA'

where b.batch_id = @batnbr
and b.project = @project
and (b.acct = @maxacct or b.acct = @addlacct)
and b.amount > 0.0

order by b.detail_num

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTran_BillMax_Reversal1] TO [MSDSL]
    AS [dbo];

