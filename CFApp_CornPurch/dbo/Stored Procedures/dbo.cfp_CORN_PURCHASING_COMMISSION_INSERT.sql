
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 10/02/2008
-- Description:	Inserts Partial ticket commission record.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_COMMISSION_INSERT
(
    @PartialTicketID		int,
    @CommissionRateTypeID	int,
    @Rate			decimal(20,6),
    @CreatedBy			varchar(50),
    @MarketerID			tinyint,
    @Percent			decimal(18,4),
    @Approved			bit
)
AS
BEGIN
SET NOCOUNT ON;

  INSERT dbo.cft_COMMISSION
  (
      [PartialTicketID],
      [CommissionRateTypeID],
      [Rate],
      [CreatedBy],
      [MarketerID],
      [Percent],
      [Approved]
  )
  VALUES
  (
      @PartialTicketID,
      @CommissionRateTypeID,
      @Rate,
      @CreatedBy,
      @MarketerID,
      @Percent,
      @Approved
  )


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_COMMISSION_INSERT] TO [db_sp_exec]
    AS [dbo];

