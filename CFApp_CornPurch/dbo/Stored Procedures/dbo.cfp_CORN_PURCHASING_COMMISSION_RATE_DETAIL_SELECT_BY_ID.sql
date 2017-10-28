
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects CommissionRateDetail record by id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_COMMISSION_RATE_DETAIL_SELECT_BY_ID]
(
    @CommissionRateDetailID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT [CommissionRateID],
       [RangeFrom],
       [RangeTo],
       [Value],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy]
FROM dbo.cft_COMMISSION_RATE_DETAIL
WHERE CommissionRateDetailID = @CommissionRateDetailID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_COMMISSION_RATE_DETAIL_SELECT_BY_ID] TO [db_sp_exec]
    AS [dbo];

