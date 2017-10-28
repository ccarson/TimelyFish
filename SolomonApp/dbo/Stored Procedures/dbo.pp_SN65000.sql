 Create Procedure pp_SN65000 @RI_ID SMALLINT

AS

Delete from SNprintQueue where RI_ID = @RI_ID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_SN65000] TO [MSDSL]
    AS [dbo];

