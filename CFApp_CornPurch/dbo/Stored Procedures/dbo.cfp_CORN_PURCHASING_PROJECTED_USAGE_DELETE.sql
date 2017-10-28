
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 11/18/2008
-- Description:	Deletes Projected Usage record
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_PROJECTED_USAGE_DELETE
(
  @ProjectedUsageID	int
)
AS
BEGIN
SET NOCOUNT ON;

DELETE dbo.cft_PROJECTED_USAGE
WHERE @ProjectedUsageID = ProjectedUsageID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_PROJECTED_USAGE_DELETE] TO [db_sp_exec]
    AS [dbo];

