

-- =======================================================================================
-- Author:	Brian Cesafsky
-- Create date: 8/3/2009
-- Description:	Deletes records from a temp table for the Interstate Pig Movement report
-- =======================================================================================
CREATE PROCEDURE [dbo].[cfp_PIG_MOVEMENT_INTERSTATE_DELETE]
AS
BEGIN
	DELETE dbo.cft_PIG_MOVEMENT_INTERSTATE_TEMP
	WHERE CreatedDateTime < dateadd(d,-7,getdate())
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_MOVEMENT_INTERSTATE_DELETE] TO [db_sp_exec]
    AS [dbo];

