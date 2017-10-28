 Create Procedure pp_SD65000 @RI_ID SMALLINT

AS

Delete from SDprintQueue where RI_ID = @RI_ID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_SD65000] TO [MSDSL]
    AS [dbo];

