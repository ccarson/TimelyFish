
CREATE proc [dbo].[Release_After]
 @batnbr varchar(10),
 @userid varchar (10)
as 

update 
	Batch 
SET 
	Batch.LUpd_DateTime = getdate(),
	Batch.LUpd_Prog = 'PARPT',
	Batch.LUpd_User = @userId,
	Batch.Status = 'U'
where
	module = 'PA' and 
	batnbr = @batnbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[Release_After] TO [MSDSL]
    AS [dbo];

