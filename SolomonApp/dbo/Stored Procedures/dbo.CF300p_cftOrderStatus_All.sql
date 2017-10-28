Create Procedure CF300p_cftOrderStatus_All as 
    Select * from cftOrderStatus Order by Status

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF300p_cftOrderStatus_All] TO [MSDSL]
    AS [dbo];

