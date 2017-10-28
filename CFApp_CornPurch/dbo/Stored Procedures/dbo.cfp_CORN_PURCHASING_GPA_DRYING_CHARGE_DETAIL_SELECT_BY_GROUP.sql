
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects GpaDryingChargeDetail record by group id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_DRYING_CHARGE_DETAIL_SELECT_BY_GROUP]
(
    @GPADryingChargeID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT [GPADryingChargeDetailID],
       [Increment],
       [RangeFrom],
       [RangeTo],
       [Value],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy]
FROM dbo.cft_GPA_DRYING_CHARGE_DETAIL
WHERE GPADryingChargeID = @GPADryingChargeID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_DRYING_CHARGE_DETAIL_SELECT_BY_GROUP] TO [db_sp_exec]
    AS [dbo];

