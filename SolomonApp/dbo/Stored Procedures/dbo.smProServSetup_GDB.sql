 CREATE PROCEDURE smProServSetup_GDB
AS
	SELECT HoursOprFromMi, HoursOprToMi
	FROM smProServSetup (nolock)
	WHERE SetupID = 'PROSETUP'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smProServSetup_GDB] TO [MSDSL]
    AS [dbo];

