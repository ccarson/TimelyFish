 CREATE PROCEDURE smDispSetup_All
AS
	SELECT *
	FROM smDispSetup
	WHERE DispSetupID = 'DISP-SETUP'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smDispSetup_All] TO [MSDSL]
    AS [dbo];

