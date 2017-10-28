
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects all GpaDryingChargeDetail records
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_DRYING_CHARGE_DETAIL_SELECT]
AS
BEGIN
SET NOCOUNT ON;

SELECT [GPADryingChargeDetailID],
       [GPADryingChargeID],
       [Increment],
       [RangeFrom],
       [RangeTo],
       [Value],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy]
FROM dbo.cft_GPA_DRYING_CHARGE_DETAIL
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_DRYING_CHARGE_DETAIL_SELECT] TO [db_sp_exec]
    AS [dbo];

