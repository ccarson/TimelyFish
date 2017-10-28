
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 04/07/2008
-- Description:	Updates the daily price record
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_DAILY_PRICE_UPDATE
(
    @DailyPriceID		int,
    @Date			datetime,
    @FeedMillID			char(10),
    @Approved			bit,
    @UpdatedBy			varchar(50)      
)
AS
BEGIN
SET NOCOUNT ON;

UPDATE dbo.cft_DAILY_PRICE SET
    Date = @Date,
    FeedMillID = @FeedMIllID,
    Approved = @Approved,
    UpdatedBy = @UpdatedBy,
    UpdatedDateTime = getdate() 
WHERE DailyPriceID = @DailyPriceID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_DAILY_PRICE_UPDATE] TO [db_sp_exec]
    AS [dbo];

