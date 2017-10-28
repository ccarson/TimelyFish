Create Procedure CF395p_cftCFSetUp_All as 
    Select * from cftFOSetUp

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF395p_cftCFSetUp_All] TO [MSDSL]
    AS [dbo];

