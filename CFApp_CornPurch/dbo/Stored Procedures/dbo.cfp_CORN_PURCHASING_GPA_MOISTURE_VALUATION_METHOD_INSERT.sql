
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/19/2008
-- Description:	Creates new GpaMoistureValuationMethod record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_VALUATION_METHOD_INSERT]
(
    @GPAMoistureValuationMethodID	int	OUT,
    @Name	varchar(100),
    @CreatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  INSERT dbo.cft_GPA_MOISTURE_VALUATION_METHOD
  (
      [Name],
      [CreatedBy]
  )
  VALUES
  (
      @Name,
      @CreatedBy
  )

  SELECT @GPAMoistureValuationMethodID = GPAMoistureValuationMethodID
  FROM dbo.cft_GPA_MOISTURE_VALUATION_METHOD
  WHERE GPAMoistureValuationMethodID = SCOPE_IDENTITY()

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_VALUATION_METHOD_INSERT] TO [db_sp_exec]
    AS [dbo];

