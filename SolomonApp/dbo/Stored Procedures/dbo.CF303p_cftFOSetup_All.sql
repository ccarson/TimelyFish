Create Procedure CF303p_cftFOSetup_All as 
    Select * from cftFOSetUp

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF303p_cftFOSetup_All] TO [MSDSL]
    AS [dbo];

