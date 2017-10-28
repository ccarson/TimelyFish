
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/19/2008
-- Description:	Selects GpaMoistureValuationMethod record by id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_VALUATION_METHOD_SELECT_BY_ID]
(
    @GPAMoistureValuationMethodID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT Name,
       CreatedDateTime,
       CreatedBy,
       UpdatedDateTime,
       UpdatedBy
FROM dbo.cft_GPA_MOISTURE_VALUATION_METHOD
WHERE GPAMoistureValuationMethodID = @GPAMoistureValuationMethodID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_VALUATION_METHOD_SELECT_BY_ID] TO [db_sp_exec]
    AS [dbo];

