CREATE PROCEDURE XDDSetupEx_All AS
  Select * from XDDSetupEx

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDSetupEx_All] TO [MSDSL]
    AS [dbo];

