
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 01/04/2008
-- Description:	Updates competitor record.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_COMPETITOR_UPDATE
(
	@CompetitorID		int,
	@FeedMillID		char(10),
	@FeedMillName		varchar(50)	OUT,
	@Name			varchar(50),
	@ShowOnReport		bit,
	@Inactive		bit,
	@ReturnValue		int		OUT,
	@Index			bit,
	@UseInAverage		bit,
	@UpdatedBy		varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

SET @ReturnValue = 0

IF EXISTS(SELECT TOP 1 1 
          FROM dbo.cft_COMPETITOR
          WHERE FeedmillID = @FeedMIllID AND Name = @Name AND CompetitorID <> @CompetitorID)
BEGIN
  
  SET @ReturnValue = 2 --Name is not unique for FeedMill


END ELSE BEGIN

  UPDATE dbo.cft_COMPETITOR SET 
      [FeedMillID] = @FeedMillID, 
      [Name] = @Name,
      [ShowOnReport] = @ShowOnReport,
      [Inactive] = @Inactive,
      [Index] = @Index,
      [UseInAverage] = @UseInAverage,
      [UpdatedBy] = @UpdatedBy,
      [UpdatedDateTime] = getdate()
  WHERE CompetitorID = @CompetitorID

  SELECT @FeedMillName = FM.Name
  FROM dbo.cft_COMPETITOR C
  INNER JOIN dbo.cft_FEED_MILL FM ON C.FeedMillID = FM.FeedMillID
  WHERE C.CompetitorID = @CompetitorID

END
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_COMPETITOR_UPDATE] TO [db_sp_exec]
    AS [dbo];

