 CREATE PROCEDURE DMG_CS_Installed_Return
AS
	if (
	select	count(*)
	from	CSSetup (NOLOCK)
	) = 0
		return 0
	else
		return 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_CS_Installed_Return] TO [MSDSL]
    AS [dbo];

