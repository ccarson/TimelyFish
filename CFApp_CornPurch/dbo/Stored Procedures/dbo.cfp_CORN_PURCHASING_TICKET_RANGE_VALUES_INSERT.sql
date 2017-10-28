

-- ===================================================================
-- Author:	Nick Honetschlager
-- Create date: 01/20/2015
-- Description:	Creates new range value record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_TICKET_RANGE_VALUES_INSERT]
(
	@RangeValueID int OUT,
    @FeedMillID varchar(10), 
    @MaxDryBushels	decimal(18,4),
    @MaxForeignMaterial	decimal(18,4),
    @MinMoistureContent	decimal(18,4),
    @MaxMoistureContent	decimal(18,4),
    @MaxNetWeight	decimal(18,4),
    @MinTestWeight	decimal(18,4),
    @MaxTestWeight	decimal(18,4),
    @CreatedBy		varchar(50) 
    
)
AS
BEGIN
  SET NOCOUNT ON

  INSERT dbo.[cft_CORN_PURCHASING_TICKET_RANGE_VALUES]
  (
      [CreatedDateTime]
      ,[CreatedBy]
      ,[FeedMillID]
      ,[MaxDryBushels]
      ,[MaxForeignMaterial]
      ,[MinMoistureContent]
      ,[MaxMoistureContent]
      ,[MaxNetWeight]
      ,[MinTestWeight]
      ,[MaxTestWeight]
  )
  VALUES
  (
      GETDATE(),
      @CreatedBy,
      @FeedMillID,
      @MaxDryBushels,
      @MaxForeignMaterial,
      @MinMoistureContent,
      @MaxMoistureContent,
      @MaxNetWeight,
      @MinTestWeight,
      @MaxTestWeight
  )

  SELECT @RangeValueID = RangeValueID
  FROM dbo.[cft_CORN_PURCHASING_TICKET_RANGE_VALUES]
  WHERE RangeValueID = SCOPE_IDENTITY()

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_TICKET_RANGE_VALUES_INSERT] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_TICKET_RANGE_VALUES_INSERT] TO [db_sp_exec]
    AS [dbo];

