 CREATE PROCEDURE WOPJPTDSum_Acct_Task
   @Project    varchar( 16 ),
   @Task       varchar( 32 ),
   @Acct       varchar( 16 )

AS
   SELECT      *
   FROM     	PJPTDSum
   WHERE    	Project = @Project and
         		PJT_Entity = @Task and
         		Acct = @Acct
   ORDER BY    Project, PJT_Entity, Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJPTDSum_Acct_Task] TO [MSDSL]
    AS [dbo];

