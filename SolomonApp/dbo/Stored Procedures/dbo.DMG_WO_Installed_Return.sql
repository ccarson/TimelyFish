 CREATE PROCEDURE DMG_WO_Installed_Return
AS
	if (
	select	count(*)
	from	WOSetup (NOLOCK)
	where	Init = 'Y'
	) = 0
		return 0
	else
		return 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_WO_Installed_Return] TO [MSDSL]
    AS [dbo];

