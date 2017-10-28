Create Procedure xMarionPrices_Comp @parm1 varchar (10) as 
    Select * from xMarionPrices Where Comptr Like @parm1
	Order by MPDate DESC, Comptr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[xMarionPrices_Comp] TO [MSDSL]
    AS [dbo];

