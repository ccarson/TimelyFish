 CREATE PROCEDURE DMG_CM_Installed_Return
AS
	if (
	select	count(*)
	from	CMSetup (NOLOCK)
	) = 0
		return 0
	else
		return 1


