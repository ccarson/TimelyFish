Create Procedure CF522p_cftPGSetUp_All as 
    Select * from cftPGSetUp

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF522p_cftPGSetUp_All] TO [MSDSL]
    AS [dbo];

