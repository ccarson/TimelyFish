Create Procedure CF399p_cftCFSetUp_All as 
    Select * from cftFOSetUp

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF399p_cftCFSetUp_All] TO [MSDSL]
    AS [dbo];

