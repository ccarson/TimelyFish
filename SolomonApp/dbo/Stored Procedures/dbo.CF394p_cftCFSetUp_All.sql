Create Procedure CF394p_cftCFSetUp_All as 
    Select * from cftFOSetUp

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF394p_cftCFSetUp_All] TO [MSDSL]
    AS [dbo];

