Create Procedure CF395p_cftFOSetup_All as 
    Select * from cftFOSetUp

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF395p_cftFOSetup_All] TO [MSDSL]
    AS [dbo];

