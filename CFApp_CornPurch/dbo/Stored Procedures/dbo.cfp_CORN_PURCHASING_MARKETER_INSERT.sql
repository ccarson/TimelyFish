
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 04/17/2008
-- Description:	Creates new Marketer record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_MARKETER_INSERT]
(
    @MarketerID	tinyint	OUT,
    @FirstName	varchar(50),
    @MiddleInitial	varchar(50),
    @LastName	varchar(50),
    @EmployeeID	varchar(50),
    @MarketerStatusID	tinyint,
    @CreatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  INSERT dbo.cft_MARKETER
  (
      [FirstName],
      [MiddleInitial],
      [LastName],
      [EmployeeID],
      [MarketerStatusID],
      [CreatedBy]
  )
  VALUES
  (
      @FirstName,
      @MiddleInitial,
      @LastName,
      @EmployeeID,
      @MarketerStatusID,
      @CreatedBy
  )

  SELECT @MarketerID = MarketerID
  FROM dbo.cft_MARKETER
  WHERE MarketerID = SCOPE_IDENTITY()

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_MARKETER_INSERT] TO [db_sp_exec]
    AS [dbo];

