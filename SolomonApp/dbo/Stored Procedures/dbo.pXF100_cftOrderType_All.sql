Create Procedure pXF100_cftOrderType_All as 
    Select * from cftOrderType Order by OrdType

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF100_cftOrderType_All] TO [MSDSL]
    AS [dbo];

