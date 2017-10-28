 CREATE PROCEDURE DMG_WO_Installed
AS
	select	case when count(*) > 0
		then 1
		else 0
		end
	from	WOSetup (nolock)
	where	Init = 'Y'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_WO_Installed] TO [MSDSL]
    AS [dbo];

