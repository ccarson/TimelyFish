
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 04/17/2008
-- Description:	Selects all Marketer records
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_MARKETER_SELECT]
AS
BEGIN
SET NOCOUNT ON;

SELECT MarketerID,
       FirstName,
       MiddleInitial,
       LastName,
       EmployeeID,
       MarketerStatusID,
       CreatedDateTime,
       CreatedBy,
       UpdatedDateTime,
       UpdatedBy
FROM dbo.cft_MARKETER
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_MARKETER_SELECT] TO [db_sp_exec]
    AS [dbo];

