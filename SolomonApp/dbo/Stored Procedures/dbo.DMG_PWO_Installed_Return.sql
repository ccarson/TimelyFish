 CREATE PROCEDURE DMG_PWO_Installed_Return
AS
	if (
	select	count(*)
	from	WOSetup (NOLOCK)
	where	Init = 'Y'
	and	substring(regoptions, 4, 1) = 'Y'       -- PWO switch
	) = 0
		return 0
	else
		return 1


