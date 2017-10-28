
Create Procedure getPJAcct
	@parm1 varchar(10)    
AS
	select * from PJ_Account
	where gl_acct = @parm1

