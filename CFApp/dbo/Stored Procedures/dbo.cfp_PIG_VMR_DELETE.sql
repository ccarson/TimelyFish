-- ==================================================
-- Author:		<Brian Cesafsky>
-- Create date: <11/26/2007>
-- Description:	<Deletes a Pig VMR record>
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_PIG_VMR_DELETE]
(
	@VmrID						int
)	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Delete from dbo.cft_PIG_VMR
	WHERE VmrID = @VmrID
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_VMR_DELETE] TO [db_sp_exec]
    AS [dbo];

