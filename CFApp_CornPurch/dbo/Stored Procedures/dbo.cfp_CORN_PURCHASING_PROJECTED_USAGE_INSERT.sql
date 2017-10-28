
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 11/18/2008
-- Description:	Inserts Projected Usage record
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_PROJECTED_USAGE_INSERT
(
  @ProjectedUsageID	int	OUT,
  @Year			int,
  @Month		int,
  @ProjectedUsage	decimal(10,0),
  @FeedMillID		char(10),
  @CreatedBy		varchar(50)
)
AS
BEGIN
SET NOCOUNT ON;

INSERT dbo.cft_PROJECTED_USAGE
(
    Year,
    Month,
    ProjectedUsage,
    FeedMillID,
    CreatedBy
)
VALUES
(
    @Year,
    @Month,
    @ProjectedUsage,
    @FeedMillID,
    @CreatedBy
)

SET @ProjectedUsageID = SCOPE_IDENTITY()
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_PROJECTED_USAGE_INSERT] TO [db_sp_exec]
    AS [dbo];

