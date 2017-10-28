Create Procedure xAssignments_CtrctNbr_VendId @parm1 varchar (10), @parm2 varchar (15) as 
    Select x.*, v.* from xAssignments x Join Vendor v on x.VendId = v.VendId 
	Where x.CtrctNbr = @parm1 and x.VendId Like @parm2 
	Order by x.CtrctNbr, x.VendId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[xAssignments_CtrctNbr_VendId] TO [MSDSL]
    AS [dbo];

