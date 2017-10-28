
-- ==================================================
-- Author:		<Brian Cesafsky>
-- Create date: <11/07/2007>
-- Description:	<Delete Packer SortLoss record>
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_PACKER_SORT_LOSS_DELETE]
(
	@SortLossID					int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE dbo.cft_PACKER_SORT_LOSS
	WHERE SortLossID = @SortLossID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKER_SORT_LOSS_DELETE] TO [db_sp_exec]
    AS [dbo];

