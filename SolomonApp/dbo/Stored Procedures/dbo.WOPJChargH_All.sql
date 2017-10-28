 CREATE PROCEDURE WOPJChargH_All
   @Batch_ID   varchar( 10 )

AS
   SELECT      *
   FROM     	PJChargH
   WHERE    	Batch_ID LIKE @Batch_ID
   ORDER BY    Batch_ID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJChargH_All] TO [MSDSL]
    AS [dbo];

