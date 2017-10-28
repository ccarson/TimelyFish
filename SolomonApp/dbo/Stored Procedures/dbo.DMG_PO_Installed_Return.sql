 CREATE PROCEDURE DMG_PO_Installed_Return
AS
	if (
	select	count(*)
	from	POSetup (NOLOCK)
	) = 0
		return 0
	else
		return 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_Installed_Return] TO [MSDSL]
    AS [dbo];

