 CREATE PROCEDURE ADS_FC_Installed
AS
	-- Force to uninstalled until FCSetup table is added to the schema
	select	0

	--select  count(*) > 0
	--	then 1
	--	else 0
	--	end
	--from	FCSetup (nolock)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADS_FC_Installed] TO [MSDSL]
    AS [dbo];

