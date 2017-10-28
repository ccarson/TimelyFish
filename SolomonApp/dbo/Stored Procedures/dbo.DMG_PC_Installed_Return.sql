 CREATE PROCEDURE DMG_PC_Installed_Return
AS
	if (
	select	count(*)
	from	PCSetup (NOLOCK)
	where	S4Future3 = 'S'
	) = 0
		return 0
	else
		return 1


