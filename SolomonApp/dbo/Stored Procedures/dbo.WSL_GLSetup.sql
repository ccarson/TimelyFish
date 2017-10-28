
CREATE PROCEDURE WSL_GLSetup
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
AS
  SET NOCOUNT ON
  SELECT * FROM GLSetup

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_GLSetup] TO [MSDSL]
    AS [dbo];

