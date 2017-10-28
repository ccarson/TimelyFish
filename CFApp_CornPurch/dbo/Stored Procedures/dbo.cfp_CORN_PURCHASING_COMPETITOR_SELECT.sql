
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 04/01/2008
-- Description:	Selects all competitor records
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_COMPETITOR_SELECT
AS
BEGIN
SET NOCOUNT ON;

SELECT C.CompetitorID,
       C.FeedMillID,
       FM.Name AS FeedMillName,
       C.Name,
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
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_COMPETITOR_SELECT] TO [db_sp_exec]
    AS [dbo];

