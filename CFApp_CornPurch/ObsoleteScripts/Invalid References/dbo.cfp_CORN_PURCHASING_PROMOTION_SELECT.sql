
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects all Promotion records
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_PROMOTION_SELECT]
AS
BEGIN
SET NOCOUNT ON;

SELECT [PromotionID],
       [FeedMillID],
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
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_PROMOTION_SELECT] TO [db_sp_exec]
    AS [dbo];

