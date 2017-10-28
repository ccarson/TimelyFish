Create Procedure CF300p_cftPriority_All as 
    Select * from cftPriority Order by Priority

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF300p_cftPriority_All] TO [MSDSL]
    AS [dbo];

