CREATE PROCEDURE XDDBank_All
	@parm1		varchar(10),
	@parm2 		varchar(10),
	@parm3 		varchar(24)
AS
  	Select 		*
  	from 		XDDBank
  	where 		CpnyID LIKE @parm1
  			and Acct like @parm2
  			and Sub like @parm3
  	ORDER by 	CpnyID, Acct, Sub

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBank_All] TO [MSDSL]
    AS [dbo];

