
-- ===================================================================
-- Author:  Andrew Derco
-- Create date: 06/30/2008
-- Description: Selects all FeedMill records
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_FEED_MILL_SELECT
AS
BEGIN
SET NOCOUNT ON;

SELECT [FeedMillID],
       [Name],
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
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_FEED_MILL_SELECT] TO [db_sp_exec]
    AS [dbo];

