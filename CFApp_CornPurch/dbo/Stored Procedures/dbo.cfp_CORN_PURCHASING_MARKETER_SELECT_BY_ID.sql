
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 04/17/2008
-- Description:	Selects Marketer record by id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_MARKETER_SELECT_BY_ID]
(
    @MarketerID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT FirstName,
       MiddleInitial,
       LastName,
       EmployeeID,
       MarketerStatusID,
       CreatedDateTime,
       CreatedBy,
       UpdatedDateTime,
       UpdatedBy
FROM dbo.cft_MARKETER
WHERE MarketerID = @MarketerID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_MARKETER_SELECT_BY_ID] TO [db_sp_exec]
    AS [dbo];

