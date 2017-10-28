Create Procedure CF300p_cfvBin_BinNbr @parm1 varchar (6), @parm2 varchar (6) as 
    Select * from cfvBin Where ContactId = @parm1 and BinNbr Like @parm2
	Order by ContactId, BinNbr	

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF300p_cfvBin_BinNbr] TO [MSDSL]
    AS [dbo];

