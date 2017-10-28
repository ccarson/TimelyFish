-- ==================================================
-- Author:		<Brian Cesafsky>
-- Create date: <12/20/2007>
-- Description:	<Selects Pig Weight record(s)>
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_PIG_WEIGHT_SELECT]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select [PigWeightID],
			[LowWeight],
			[HighWeight]
	from dbo.cft_PIG_WEIGHT (NOLOCK)
	Order By LowWeight asc, HighWeight asc
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_WEIGHT_SELECT] TO [db_sp_exec]
    AS [dbo];

