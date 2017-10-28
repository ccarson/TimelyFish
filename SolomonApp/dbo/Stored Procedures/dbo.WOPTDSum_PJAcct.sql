 CREATE PROCEDURE WOPTDSum_PJAcct
   @Project    varchar( 16 ),
   @Acct       varchar( 16 ),
   @Task       varchar( 32 )

AS
   SELECT      *
   FROM     	PJPTDSum LEFT JOIN PJAcct
         		ON PJPTDSum.Acct = PJAcct.Acct
   WHERE    	PJPTDSum.Project = @Project and
         		PJPTDSum.Acct LIKE @Acct and
         		PJPTDSum.PJT_Entity LIKE @Task
   ORDER BY    PJPTDSum.Project, PJAcct.Acct_Type DESC, PJAcct.Sort_Num, PJAcct.Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPTDSum_PJAcct] TO [MSDSL]
    AS [dbo];

