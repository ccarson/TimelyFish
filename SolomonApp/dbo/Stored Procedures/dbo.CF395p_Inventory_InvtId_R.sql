Create Procedure CF395p_Inventory_InvtId_R @parm1 varchar (6), @parm2 varchar (30) as 
    Select * from Inventory Where ClassId = @parm1 and InvtId Like @parm2
	Order by InvtId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF395p_Inventory_InvtId_R] TO [MSDSL]
    AS [dbo];

