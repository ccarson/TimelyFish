
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 04/17/2008
-- Description:	Updates the Marketer record.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_MARKETER_UPDATE]
(
    @MarketerID	tinyint,
    @FirstName	varchar(50),
    @MiddleInitial	varchar(50),
    @LastName	varchar(50),
    @EmployeeID	varchar(50),
    @MarketerStatusID	tinyint,
    @UpdatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  UPDATE dbo.cft_MARKETER SET
    FirstName = @FirstName,
    MiddleInitial = @MiddleInitial,
    LastName = @LastName,
    EmployeeID = @EmployeeID,
    MarketerStatusID = @MarketerStatusID,
    UpdatedBy = @UpdatedBy,
    UpdatedDateTime = getdate()
WHERE MarketerID = @MarketerID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_MARKETER_UPDATE] TO [db_sp_exec]
    AS [dbo];

