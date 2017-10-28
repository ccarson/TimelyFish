
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects CommissionRateDetail record by id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_COMMISSION_RATE_DETAIL_SELECT_BY_GROUP]
(
    @CommissionRateID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT [CommissionRateDetailID],
       [RangeFrom],
       [RangeTo],
       [Value],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy]
FROM dbo.cft_COMMISSION_RATE_DETAIL
WHERE CommissionRateID = @CommissionRateID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_COMMISSION_RATE_DETAIL_SELECT_BY_GROUP] TO [db_sp_exec]
    AS [dbo];

