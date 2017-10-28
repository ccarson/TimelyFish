
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects all GpaMoistureChargeDetail records
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_CHARGE_DETAIL_SELECT]
AS
BEGIN
SET NOCOUNT ON;

SELECT [GPAMoistureChargeDetailID],
       [GPAMoistureChargeID],
       [Increment],
       [RangeFrom],
       [RangeTo],
       [Value],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy]
FROM dbo.cft_GPA_MOISTURE_CHARGE_DETAIL
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_CHARGE_DETAIL_SELECT] TO [db_sp_exec]
    AS [dbo];

