Create Procedure xContract_VendId_CtrctNbr @parm1 varchar (15), @parm2 varchar (10) as 
    Select * from xContract Where Seller = @parm1 and Status = 'O' and CtrctNbr Like @parm2 
	Order by CtrctNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[xContract_VendId_CtrctNbr] TO [MSDSL]
    AS [dbo];

