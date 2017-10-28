

-- ===================================================================
-- Author:	Nick Honetschlager
-- Create date: 11/28/2014
-- Description:	Selects all Corn Ticket Range Values records
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_TICKET_RANGE_VALUES_SELECT_BY_FEED_MILL]
(
    @FeedMillID	char(10)
)
AS
BEGIN
SET NOCOUNT ON;

SELECT [CreatedDateTime]
      ,[CreatedBy]
      ,[FeedMillID]
      ,[MaxDryBushels]
      ,[MaxForeignMaterial]
      ,[MinMoistureContent]
      ,[MaxMoistureContent]
      ,[MaxNetWeight]
      ,[MinTestWeight]
      ,[MaxTestWeight]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,[RangeValueID]
FROM [dbo].[cft_CORN_PURCHASING_TICKET_RANGE_VALUES]
WHERE FeedMillID = @FeedMillID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_TICKET_RANGE_VALUES_SELECT_BY_FEED_MILL] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_TICKET_RANGE_VALUES_SELECT_BY_FEED_MILL] TO [db_sp_exec]
    AS [dbo];

