 CREATE PROCEDURE WOPJChargH_Update_Status
   @Batch_ID		varchar( 10 ),
   @Batch_Status	varchar( 1 )

AS
   UPDATE		PJChargH
   SET			Batch_Status = @Batch_Status
   WHERE    		Batch_ID LIKE @Batch_ID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJChargH_Update_Status] TO [MSDSL]
    AS [dbo];

