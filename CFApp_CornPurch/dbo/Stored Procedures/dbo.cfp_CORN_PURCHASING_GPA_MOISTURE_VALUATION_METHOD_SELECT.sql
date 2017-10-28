
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/19/2008
-- Description:	Selects all GpaMoistureValuationMethod records
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_VALUATION_METHOD_SELECT]
AS
BEGIN
SET NOCOUNT ON;

SELECT GPAMoistureValuationMethodID,
       Name,
       CreatedDateTime,
       CreatedBy,
       UpdatedDateTime,
       UpdatedBy
FROM dbo.cft_GPA_MOISTURE_VALUATION_METHOD
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_VALUATION_METHOD_SELECT] TO [db_sp_exec]
    AS [dbo];

