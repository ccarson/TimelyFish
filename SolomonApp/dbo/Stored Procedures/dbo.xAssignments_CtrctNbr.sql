Create Procedure xAssignments_CtrctNbr @parm1 varchar (10) as 
    Select * from xAssignments Where CtrctNbr = @parm1
	Order by CtrctNbr, VendId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[xAssignments_CtrctNbr] TO [MSDSL]
    AS [dbo];

