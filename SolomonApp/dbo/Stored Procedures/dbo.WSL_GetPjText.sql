
CREATE PROCEDURE [dbo].[WSL_GetPjText]
 @parm1 char (4) -- Message number
AS
  SET NOCOUNT ON
  
  SELECT msg_text
  FROM PJTEXT
  WHERE msg_num = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_GetPjText] TO [MSDSL]
    AS [dbo];

