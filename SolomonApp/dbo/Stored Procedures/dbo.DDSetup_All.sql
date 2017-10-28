 Create Proc DDSetup_All as
    Select * from DDSetup ORDER by SetupId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DDSetup_All] TO [MSDSL]
    AS [dbo];

