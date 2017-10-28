
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 01/04/2008
-- Description:	Creates new competitor record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_COMPETITOR_INSERT
(
	@CompetitorID		int		OUT,
	@FeedMillID		char(10),
	@FeedMillName		varchar(50)	OUT,
	@Name			varchar(50),
	@ShowOnReport		bit,
	@Inactive		bit,
	@ReturnValue		int		OUT,
	@CreatedBy		varchar(50),
	@Index			bit,
	@UseInAverage		bit
)
AS
BEGIN
  SET NOCOUNT ON

SET @ReturnValue = 0

IF EXISTS(SELECT TOP 1 1 
          FROM dbo.cft_COMPETITOR
          WHERE FeedmillID = @FeedMIllID AND Name = @Name)
BEGIN
  
  SET @ReturnValue = 2 --Name is not unique for FeedMill


END ELSE BEGIN

  INSERT dbo.cft_COMPETITOR  
  (
      [FeedMillID], 
      [Name],
      [ShowOnReport],
      [Inactive],
      [Index],
      [UseInAverage],
      [CreatedBy]
  ) 
  VALUES 
  (
      @FeedMillID, 
      @Name,
      @ShowOnReport,
      @Inactive,
      @Index,
      @UseInAverage,
      @CreatedBy
  )

  SELECT @CompetitorID = C.CompetitorID, @FeedMillName = FM.Name
  FROM dbo.cft_COMPETITOR C
  INNER JOIN dbo.cft_FEED_MILL FM ON C.FeedMillID = FM.FeedMillID
  WHERE CompetitorID = SCOPE_IDENTITY() 
END
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_COMPETITOR_INSERT] TO [db_sp_exec]
    AS [dbo];

