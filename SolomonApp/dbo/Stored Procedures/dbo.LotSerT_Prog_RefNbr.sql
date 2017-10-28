 Create Proc LotSerT_Prog_RefNbr @parm1 varchar (8), @parm2 varchar (15) as
    	Select * from LotSerT where
		Crtd_Prog = @parm1 and
		RefNbr = @parm2
                order by LotSerNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LotSerT_Prog_RefNbr] TO [MSDSL]
    AS [dbo];

