
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects GpaMoistureChargeDetail record by id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_CHARGE_DETAIL_SELECT_BY_ID]
(
    @GPAMoistureChargeDetailID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT [GPAMoistureChargeID],
       [Increment],
       [RangeFrom],
       [RangeTo],
       [Value],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy]
FROM dbo.cft_GPA_MOISTURE_CHARGE_DETAIL
WHERE GPAMoistureChargeDetailID = @GPAMoistureChargeDetailID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_CHARGE_DETAIL_SELECT_BY_ID] TO [db_sp_exec]
    AS [dbo];

