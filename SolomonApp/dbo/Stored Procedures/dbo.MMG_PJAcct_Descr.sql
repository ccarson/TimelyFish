 CREATE PROCEDURE MMG_PJAcct_Descr
	@Acct      varchar(16)
AS
   SELECT     Acct_Desc
	FROM 	     PJAcct
   WHERE 	  Acct = @Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[MMG_PJAcct_Descr] TO [MSDSL]
    AS [dbo];

