CREATE PROCEDURE XDDSetup_All AS
  Select * from XDDSetup ORDER by SetupId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDSetup_All] TO [MSDSL]
    AS [dbo];

