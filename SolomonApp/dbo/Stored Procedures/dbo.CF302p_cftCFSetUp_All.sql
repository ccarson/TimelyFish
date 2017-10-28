Create Procedure CF302p_cftCFSetUp_All as 
    Select * from cftFOSetUp

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF302p_cftCFSetUp_All] TO [MSDSL]
    AS [dbo];

