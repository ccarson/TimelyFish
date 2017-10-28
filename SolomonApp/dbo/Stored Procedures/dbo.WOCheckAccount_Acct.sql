 create proc WOCheckAccount_Acct
   	@Account	varchar(10),	-- GL Account
   	@Acct		varchar(16)	-- PA Account Category
as

	if exists(	SELECT * from PJ_Account (nolock)
			WHERE	gl_acct = @Account
				and acct = @Acct)
		Select	1
	else
		Select 	0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOCheckAccount_Acct] TO [MSDSL]
    AS [dbo];

