Create Procedure CF300p_cftOrderType_All as 
    Select * from cftOrderType Order by OrdType

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF300p_cftOrderType_All] TO [MSDSL]
    AS [dbo];

