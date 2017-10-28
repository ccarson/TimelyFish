
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects all CommissionRateDetail records
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_COMMISSION_RATE_DETAIL_SELECT]
AS
BEGIN
SET NOCOUNT ON;

SELECT [CommissionRateDetailID],
       [CommissionRateID],
       [RangeFrom],
       [RangeTo],
       [Value],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy]
FROM dbo.cft_COMMISSION_RATE_DETAIL
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_COMMISSION_RATE_DETAIL_SELECT] TO [db_sp_exec]
    AS [dbo];

