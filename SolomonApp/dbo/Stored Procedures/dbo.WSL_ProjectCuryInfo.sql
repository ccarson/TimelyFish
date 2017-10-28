
CREATE PROCEDURE WSL_ProjectCuryInfo
 @parm1 varchar (16) -- Project
AS
  SET NOCOUNT ON
  SELECT billcuryid, billratetypeid
  FROM PJPROJ
  WHERE project = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectCuryInfo] TO [MSDSL]
    AS [dbo];

