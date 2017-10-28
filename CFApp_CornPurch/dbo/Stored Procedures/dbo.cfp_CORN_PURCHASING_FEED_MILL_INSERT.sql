
-- ===================================================================
-- Author:  Andrew Derco
-- Create date: 06/30/2008
-- Description: Creates new FeedMill record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_FEED_MILL_INSERT
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
    @CreatedBy  varchar(50),
    @Company	varchar(100)
)
AS
BEGIN
  SET NOCOUNT ON

  INSERT dbo.cft_FEED_MILL
  (
      [FeedMillID],
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
      [CreatedBy],
      [Company]
  )
  VALUES
  (
      @FeedMillID,
      @Name,
      @Address1,
      @Address2,
      @City,
      @State,
      @Zip,
      @County,
      @SentToDryer,
      @DryerCapacity,
      @UnloadingTime,
      @ReceivingHours,
      @GrainDealerLicenseNumber,
      @Comments,
      @CreatedBy,
      @Company
  )

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_FEED_MILL_INSERT] TO [db_sp_exec]
    AS [dbo];

