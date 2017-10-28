 CREATE PROCEDURE DMG_OM_Installed_Return
AS
	if (
	select	count(*)
	from	SOSetup (NOLOCK)
	) = 0
		return 0
	else
		return 1


