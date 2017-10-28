Create Procedure CF399p_cftOrderType_All as 
    Select * from cftOrderType Order by OrdType

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF399p_cftOrderType_All] TO [MSDSL]
    AS [dbo];

