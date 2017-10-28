
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 11/18/2008
-- Description:	Deletes ElevatorSaleBasis record.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_ELEVATOR_SALE_BASIS_DELETE
(
    @ElevatorSaleBasisID	int
)
AS
BEGIN
  SET NOCOUNT ON

  DELETE dbo.cft_ELEVATOR_SALE_BASIS
  WHERE ElevatorSaleBasisID = @ElevatorSaleBasisID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_ELEVATOR_SALE_BASIS_DELETE] TO [db_sp_exec]
    AS [dbo];

