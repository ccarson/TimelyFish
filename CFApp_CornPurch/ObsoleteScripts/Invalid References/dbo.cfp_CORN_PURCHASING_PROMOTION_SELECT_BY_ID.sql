
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects Promotion record by id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_PROMOTION_SELECT_BY_ID]
(
    @PromotionID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT [FeedMillID],
       [Active],
       [DateEstablishedFrom],
       [DateEstablishedTo],
       [DeliveryDateFrom],
       [DeliveryDateTo],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy]
FROM dbo.cft_PROMOTION
WHERE PromotionID = @PromotionID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_PROMOTION_SELECT_BY_ID] TO [db_sp_exec]
    AS [dbo];

