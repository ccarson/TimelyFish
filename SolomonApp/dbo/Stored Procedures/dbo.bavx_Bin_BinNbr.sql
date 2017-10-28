Create Procedure bavx_Bin_BinNbr @parm1 varchar (6), @parm2 varchar (6) as 
    Select * from vx_Bin Where ContactId = @parm1 and BinNbr Like @parm2
	Order by ContactId, BinNbr	

GO
GRANT CONTROL
    ON OBJECT::[dbo].[bavx_Bin_BinNbr] TO [MSDSL]
    AS [dbo];

