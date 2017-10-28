Create Procedure CF303p_cftOrderType_OT @parm1 varchar (2) as 
    Select * from cftOrderType Where OrdType = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF303p_cftOrderType_OT] TO [MSDSL]
    AS [dbo];

