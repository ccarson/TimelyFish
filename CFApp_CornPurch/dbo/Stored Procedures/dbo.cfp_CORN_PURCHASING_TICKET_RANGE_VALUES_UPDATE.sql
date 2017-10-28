

-- ===================================================================
-- Author:	Nick Honetschlager
-- Create date: 11/28/2014
-- Description:	Updates the Range Values record.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_TICKET_RANGE_VALUES_UPDATE]
(   
	@FeedMillID varchar(10), 
    @MaxDryBushels	decimal(18,4),
    @MaxForeignMaterial	decimal(18,4),
    @MinMoistureContent	decimal(18,4),
    @MaxMoistureContent	decimal(18,4),
    @MaxNetWeight	decimal(18,4),
    @MinTestWeight	decimal(18,4),
    @MaxTestWeight	decimal(18,4),
    @RangeValueID int,
    @UpdatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  UPDATE [dbo].[cft_CORN_PURCHASING_TICKET_RANGE_VALUES] SET
	   [FeedMillID] = @FeedMillID
	  ,[MaxDryBushels] = @MaxDryBushels
      ,[MaxForeignMaterial] = @MaxForeignMaterial
      ,[MinMoistureContent] = @MinMoistureContent
      ,[MaxMoistureContent] = @MaxMoistureContent
      ,[MaxNetWeight] = @MaxNetWeight
      ,[MinTestWeight] = @MinTestWeight
      ,[MaxTestWeight] = @MaxTestWeight
      ,[UpdatedDateTime] = GETDATE()
      ,[UpdatedBy] = @UpdatedBy
  WHERE RangeValueID = @RangeValueID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_TICKET_RANGE_VALUES_UPDATE] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_TICKET_RANGE_VALUES_UPDATE] TO [db_sp_exec]
    AS [dbo];

