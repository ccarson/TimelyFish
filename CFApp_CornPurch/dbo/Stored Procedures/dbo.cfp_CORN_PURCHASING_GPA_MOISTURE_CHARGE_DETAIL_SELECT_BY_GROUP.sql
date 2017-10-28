
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects GpaMoistureChargeDetail record by group id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_CHARGE_DETAIL_SELECT_BY_GROUP]
(
    @GPAMoistureChargeID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT [GPAMoistureChargeDetailID],
       [Increment],
       [RangeFrom],
       [RangeTo],
       [Value],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy]
FROM dbo.cft_GPA_MOISTURE_CHARGE_DETAIL
WHERE GPAMoistureChargeID = @GPAMoistureChargeID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_CHARGE_DETAIL_SELECT_BY_GROUP] TO [db_sp_exec]
    AS [dbo];

