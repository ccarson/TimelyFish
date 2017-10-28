
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/19/2008
-- Description:	Updates the GpaMoistureValuationMethod record.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_VALUATION_METHOD_UPDATE]
(
    @GPAMoistureValuationMethodID	int,
    @Name	varchar(100),
    @UpdatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  UPDATE dbo.cft_GPA_MOISTURE_VALUATION_METHOD SET
    Name = @Name,
    UpdatedBy = @UpdatedBy,
    UpdatedDateTime = getdate()
  WHERE GPAMoistureValuationMethodID = @GPAMoistureValuationMethodID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_VALUATION_METHOD_UPDATE] TO [db_sp_exec]
    AS [dbo];

