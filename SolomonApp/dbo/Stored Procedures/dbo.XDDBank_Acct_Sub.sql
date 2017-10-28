CREATE PROCEDURE XDDBank_Acct_Sub
	@parm1		varchar(10),
	@parm2 		varchar(10),
	@parm3 		varchar(24)
AS
  	Select 		*
  	from 		XDDBank
  	where 		CpnyID = @parm1
  			and Acct = @parm2
  			and Sub = @parm3

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBank_Acct_Sub] TO [MSDSL]
    AS [dbo];

