 CREATE PROCEDURE DMG_PWO_Installed
AS
	select	case when count(*) > 0
		then 1
		else 0
		end
	from	WOSetup (nolock)
	where	Init = 'Y' and
		substring(regoptions, 4, 1) = 'Y'       -- PWO switch


