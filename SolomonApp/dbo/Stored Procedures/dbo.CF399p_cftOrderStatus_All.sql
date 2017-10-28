Create Procedure CF399p_cftOrderStatus_All as 
    Select * from cftOrderStatus Order by Status

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF399p_cftOrderStatus_All] TO [MSDSL]
    AS [dbo];

