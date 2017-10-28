 CREATE PROCEDURE DMG_SS_Installed
AS
	select	case when count(*) > 0
		then 1
		else 0
		end
	from	smProServSetup (nolock)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SS_Installed] TO [MSDSL]
    AS [dbo];

