
-- ===================================================================
-- Author:  Andrew Derco
-- Create date: 07/11/2008
-- Description: Selects all Marketers for Contract
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_MARKETER_SELECT_DEFAULT_FOR_CORN_PRODUCER]
(
    @CornProducerID	varchar(15)
)
AS
BEGIN
SET NOCOUNT ON;

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
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_MARKETER_SELECT_DEFAULT_FOR_CORN_PRODUCER] TO [db_sp_exec]
    AS [dbo];

