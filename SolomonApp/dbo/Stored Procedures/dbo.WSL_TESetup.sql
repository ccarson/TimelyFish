
CREATE PROCEDURE [dbo].[WSL_TESetup]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
AS
  SET NOCOUNT ON
  SELECT SUBSTRING(control_data, 103, 1) AS APFlag
  FROM PJCONTRL
  WHERE control_code = 'SETUP' and control_type = 'TE'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_TESetup] TO [MSDSL]
    AS [dbo];

