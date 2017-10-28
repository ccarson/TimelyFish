
 CREATE PROCEDURE [dbo].[WS_GetFilterProjectsBySubAccount]
	@parm1 VarChar(24)
AS
  SELECT project 
    FROM PJPROJ 
   WHERE gl_subacct = @parm1
     AND project IN (SELECT project FROM PJREVHDR WHERE status = 'C')

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_GetFilterProjectsBySubAccount] TO [MSDSL]
    AS [dbo];

