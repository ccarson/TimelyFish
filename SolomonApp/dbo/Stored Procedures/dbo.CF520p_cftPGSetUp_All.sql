Create Procedure CF520p_cftPGSetUp_All as 
    Select * from cftPGSetUp

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF520p_cftPGSetUp_All] TO [MSDSL]
    AS [dbo];

