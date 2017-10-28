
CREATE proc [dbo].[GLTran_Before]
 @batnbr varchar(10),
 @userid varchar (10)
as 

update 
	Batch 
SET 
	Batch.LUpd_DateTime = getdate(),
	Batch.LUpd_Prog = 'PARPT',
	Batch.LUpd_User = @userId,
	Batch.Status = 'S'
where
	module = 'PA' and 
	batnbr = @batnbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLTran_Before] TO [MSDSL]
    AS [dbo];

