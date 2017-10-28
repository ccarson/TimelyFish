
-- ===================================================================
-- Author:  Andrew Derco
-- Create date: 06/30/2008
-- Description: Updates the FeedMill record.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_FEED_MILL_UPDATE
(
    @FeedMillID varchar(10),
    @Name varchar(50),
    @Address1 varchar(30),
    @Address2 varchar(30),
    @City varchar(30),
    @State  varchar(2),
    @Zip  varchar(10),
    @County varchar(30),
    @SentToDryer  bit,
    @DryerCapacity  money,
    @UnloadingTime  money,
    @ReceivingHours varchar(5000),
    @GrainDealerLicenseNumber varchar(50),
    @Comments varchar(5000),
    @UpdatedBy  varchar(50),
    @Company	varchar(100)
)
AS
BEGIN
  SET NOCOUNT ON

  UPDATE dbo.cft_FEED_MILL SET
    [Name] = @Name,
    [Address1] = @Address1,
    [Address2] = @Address2,
    [City] = @City,
    [State] = @State,
    [Zip] = @Zip,
    [County] = @County,
    [SentToDryer] = @SentToDryer,
    [DryerCapacity] = @DryerCapacity,
    [UnloadingTime] = @UnloadingTime,
    [ReceivingHours] = @ReceivingHours,
    [GrainDealerLicenseNumber] = @GrainDealerLicenseNumber,
    [Comments] = @Comments,
    [UpdatedBy] = @UpdatedBy,
    [Company] = @Company,
    UpdatedDateTime = getdate()
  WHERE FeedMillID = @FeedMillID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_FEED_MILL_UPDATE] TO [db_sp_exec]
    AS [dbo];

