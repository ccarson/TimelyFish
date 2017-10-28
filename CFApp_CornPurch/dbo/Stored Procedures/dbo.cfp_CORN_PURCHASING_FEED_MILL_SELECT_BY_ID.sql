
-- ===================================================================
-- Author:  Andrew Derco
-- Create date: 06/30/2008
-- Description: Selects FeedMill record by id
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_FEED_MILL_SELECT_BY_ID
(
    @FeedMillID varchar(30)
)
AS
BEGIN
SET NOCOUNT ON;

SELECT [Name],
       [Address1],
       [Address2],
       [City],
       [State],
       [Zip],
       [County],
       [SentToDryer],
       [DryerCapacity],
       [UnloadingTime],
       [ReceivingHours],
       [GrainDealerLicenseNumber],
       [Comments],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy],
       [Company]
FROM dbo.cft_FEED_MILL
WHERE FeedMillID = @FeedMillID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_FEED_MILL_SELECT_BY_ID] TO [db_sp_exec]
    AS [dbo];

