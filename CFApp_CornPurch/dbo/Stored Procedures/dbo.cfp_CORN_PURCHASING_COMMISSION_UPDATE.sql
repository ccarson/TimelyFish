
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 10/02/2008
-- Description:	Updates partial ticket commission record
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_COMMISSION_UPDATE
(
    @PartialTicketID		int,
    @CommissionRateTypeID	int,
    @Rate			decimal(20,6),
    @MarketerID			tinyint,
    @Percent			decimal(18,4),
    @Approved			bit,
    @UpdatedBy			varchar(50)
)
AS
BEGIN
SET NOCOUNT ON;


  UPDATE dbo.cft_COMMISSION SET
    [CommissionRateTypeID] = @CommissionRateTypeID,
    [Rate] = @Rate,
    [Percent] = @Percent,
    [Approved] = @Approved,
    [UpdatedBy] = @UpdatedBy,
    UpdatedDateTime = getdate()
  WHERE PartialTicketID = @PartialTicketID AND MarketerID = @MarketerID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_COMMISSION_UPDATE] TO [db_sp_exec]
    AS [dbo];

