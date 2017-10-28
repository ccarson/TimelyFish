CREATE PROCEDURE XDDSetup_SetupID @parm1 varchar(2) AS
  Select * from XDDSetup where SetupID LIKE @parm1 ORDER by SetupId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDSetup_SetupID] TO [MSDSL]
    AS [dbo];

