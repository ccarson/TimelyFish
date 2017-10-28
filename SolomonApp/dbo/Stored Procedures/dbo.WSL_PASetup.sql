
CREATE PROCEDURE [dbo].[WSL_PASetup]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
AS
  SET NOCOUNT ON
  SELECT control_data AS MultiCurrency
  FROM PJCONTRL
  WHERE control_code = 'FOREIGN-CURRENCY-BILLING' and control_type = 'PA'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_PASetup] TO [MSDSL]
    AS [dbo];

