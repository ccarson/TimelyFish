 Create Proc BMSetup_All @SetupId varchar ( 2) as
	Select * from BMSetup where
		SetupId like @SetupId
		order by SetupId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BMSetup_All] TO [MSDSL]
    AS [dbo];

