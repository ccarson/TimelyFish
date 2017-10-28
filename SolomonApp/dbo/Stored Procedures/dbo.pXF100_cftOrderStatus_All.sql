Create Procedure pXF100_cftOrderStatus_All as 
    Select * from cftOrderStatus Order by Status

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF100_cftOrderStatus_All] TO [MSDSL]
    AS [dbo];

