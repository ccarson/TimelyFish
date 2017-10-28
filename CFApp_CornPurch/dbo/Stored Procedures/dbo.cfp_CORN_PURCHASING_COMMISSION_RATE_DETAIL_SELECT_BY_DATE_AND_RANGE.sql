
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects CommissionRateDetail record by date,range and feed mill id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_COMMISSION_RATE_DETAIL_SELECT_BY_DATE_AND_RANGE]
(
    @Date		datetime,
    @Range		decimal(5,2),
    @FeedMillID		char(10),
    @PartialTicketID	int
 
)
AS
BEGIN
SET NOCOUNT ON;

DECLARE @CommissionRateTypeID int

SELECT @CommissionRateTypeID = CASE WHEN EXISTS ( SELECT 1 
                                              FROM dbo.cft_PARTIAL_TICKET PT
                                              INNER JOIN dbo.cft_CONTRACT C ON PT.ContractID = C.ContractID
                                              INNER JOIN dbo.cft_PROMOTION_RATE P ON C.DateEstablished BETWEEN P.DateEstablishedFrom AND P.DateEstablishedTo
                                                                                AND PT.DeliveryDate BETWEEN P.DeliveryDateFrom AND P.DeliveryDateTo
                                              WHERE PT.PartialTicketID = @PartialTicketID AND P.FeedMillID = @FeedMillID AND PT.DeliveryDate = @Date AND P.Active = 1
                                            ) 
                                     THEN 2 -- Promotion
                                     ELSE 1 -- Standard
                                     END

SELECT CRD.[CommissionRateDetailID],
       CRD.[CommissionRateID],
       CRD.[RangeFrom],
       CRD.[RangeTo],
       CRD.[Value],
       CRD.[CreatedDateTime],
       CRD.[CreatedBy],
       CRD.[UpdatedDateTime],
       CRD.[UpdatedBy]
FROM dbo.cft_COMMISSION_RATE_DETAIL CRD
INNER JOIN dbo.cft_STANDARD_RATE SR ON SR.CommissionRateID = CRD.CommissionRateID
WHERE SR.Active = 1 
      AND SR.CommissionRateTypeID = @CommissionRateTypeID 
      AND SR.FeedMillID = @FeedMillID
      AND @Date BETWEEN SR.EffectiveDateFrom AND SR.EffectiveDateTo
      AND @Range BETWEEN CRD.RangeFrom AND CRD.RangeTo

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_COMMISSION_RATE_DETAIL_SELECT_BY_DATE_AND_RANGE] TO [db_sp_exec]
    AS [dbo];

