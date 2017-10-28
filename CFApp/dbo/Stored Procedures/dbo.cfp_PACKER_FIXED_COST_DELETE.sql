
-- ==================================================
-- Author:		<Brian Cesafsky>
-- Create date: <12/19/2007>
-- Description:	<Delete Packer Fixed Cost record>
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_PACKER_FIXED_COST_DELETE]
(
	@FixedCostID					int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE dbo.cft_PACKER_FIXED_COST
	WHERE FixedCostID = @FixedCostID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKER_FIXED_COST_DELETE] TO [db_sp_exec]
    AS [dbo];

