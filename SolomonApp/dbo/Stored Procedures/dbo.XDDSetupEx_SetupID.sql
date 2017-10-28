CREATE PROCEDURE XDDSetupEx_SetupID @parm1 varchar(2) AS
  Select * from XDDSetupEx where SetupID LIKE @parm1 ORDER by SetupId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDSetupEx_SetupID] TO [MSDSL]
    AS [dbo];

