
-- ===================================================================
-- Author:  Andrew Derco
-- Create date: 09/19/2008
-- Description: Selects all Marketers for Contract
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_MARKETER_SELECT_BY_STATUS_WITH_DEFAULT
(
    @CornProducerID	varchar(15),
    @FeedMillID		char(10)
)
AS
BEGIN
SET NOCOUNT ON;

--Marketer field should contain marketers for selected feed mill + default marketer for Corn producer.

SELECT M.MarketerID,
       M.FirstName,
       M.MiddleInitial,
       M.LastName,
       isnull (M.FirstName + ' ' + isnull (M.MiddleInitial,'') + ' ' + isnull (M.LastName,''),'') as Name,	
       M.EmployeeID,
       M.MarketerStatusID,
       M.CreatedDateTime,
       M.CreatedBy,
       M.UpdatedDateTime,
       M.UpdatedBy
FROM dbo.cft_MARKETER M
INNER JOIN dbo.cft_MARKETER_FEED_MILL MFM ON MFM.MarketerID = M.MarketerID
WHERE MFM.FeedMillID = @FeedMillID AND M.MarketerStatusID = 1

UNION

SELECT M.MarketerID,
       M.FirstName,
       M.MiddleInitial,
       M.LastName,
       isnull (M.FirstName + ' ' + isnull (M.MiddleInitial,'') + ' ' + isnull (M.LastName,''),'') as Name,	
       M.EmployeeID,
       M.MarketerStatusID,
       M.CreatedDateTime,
       M.CreatedBy,
       M.UpdatedDateTime,
       M.UpdatedBy
FROM dbo.cft_MARKETER M
INNER JOIN dbo.cft_CORN_PRODUCER CP ON  M.MarketerID = CP.DefaultCornMarketerID
WHERE M.MarketerStatusID = 1  AND CP.CornProducerID = @CornProducerID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_MARKETER_SELECT_BY_STATUS_WITH_DEFAULT] TO [db_sp_exec]
    AS [dbo];

