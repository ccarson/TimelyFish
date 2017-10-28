
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 11/18/2008
-- Description:	Updates Projected Usage record
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_PROJECTED_USAGE_UPDATE
(
  @ProjectedUsageID	int,
  @Year			int,
  @Month		int,
  @ProjectedUsage	decimal(10,0),
  @FeedMillID		char(10),
  @UpdatedBy		varchar(50)
)
AS
BEGIN
SET NOCOUNT ON;

UPDATE dbo.cft_PROJECTED_USAGE
  SET Year = @Year,
      Month = @Month,
      FeedMillID = @FeedMillID,
      ProjectedUsage = @ProjectedUsage,
      UpdatedDateTime = getdate(),
      UpdatedBy = @UpdatedBy
  WHERE @ProjectedUsageID = ProjectedUsageID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_PROJECTED_USAGE_UPDATE] TO [db_sp_exec]
    AS [dbo];

