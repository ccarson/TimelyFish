
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 11/18/2008
-- Description:	Updates the ElevatorSaleBasis record.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_ELEVATOR_SALE_BASIS_UPDATE
(
    @ElevatorSaleBasisID	int,
    @Date			datetime,
    @FeedMillID			varchar(10),
    @Amount			decimal(10,4),
    @UpdatedBy			varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  UPDATE dbo.cft_ELEVATOR_SALE_BASIS SET
    [Date] = @Date,
    [FeedMillID] = @FeedMillID,
    [Amount] = @Amount,
    [UpdatedBy] = @UpdatedBy,
    UpdatedDateTime = getdate()
  WHERE @ElevatorSaleBasisID = ElevatorSaleBasisID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_ELEVATOR_SALE_BASIS_UPDATE] TO [db_sp_exec]
    AS [dbo];

