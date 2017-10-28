
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 04/01/2008
-- Description:	Selects the competitor record by id
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_COMPETITOR_SELECT_BY_FEED_MILL
(
	@FeedMillID	char(10)
)
AS
BEGIN
SET NOCOUNT ON;

SELECT C.CompetitorID,
       C.Name,
       FM.Name AS FeedMillName,
       C.ShowOnReport,
       C.Inactive,
       C.[Index],
       C.UseInAverage,
       C.CreatedDateTime,
       C.CreatedBy,
       C.UpdatedDateTime,
       C.UpdatedBy  
FROM dbo.cft_COMPETITOR C
INNER JOIN dbo.cft_FEED_MILL FM ON FM.FeedMillID = C.FeedMillID
WHERE C.FeedMillID = @FeedMillID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_COMPETITOR_SELECT_BY_FEED_MILL] TO [db_sp_exec]
    AS [dbo];

