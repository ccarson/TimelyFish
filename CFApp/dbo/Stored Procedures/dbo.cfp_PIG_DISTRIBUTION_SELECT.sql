-- ==================================================
-- Author:		<Brian Cesafsky>
-- Create date: <11/20/2007>
-- Description:	<Selects Pig Distribution record(s)>
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_PIG_DISTRIBUTION_SELECT]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select [PigDistributionID],
			[LiveWeight],
			[TopLoadMultiplier],
			[CloseoutLoadMultiplier]
	from dbo.cft_PIG_DISTRIBUTION (NOLOCK)
	Order By LiveWeight asc
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_DISTRIBUTION_SELECT] TO [db_sp_exec]
    AS [dbo];

