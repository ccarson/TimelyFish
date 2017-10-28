 Create Proc LotSerT_Prog_RefNbr_InvtId @parm1 varchar (8), @parm2 varchar (15), @parm3 varchar (30) as
    	Select * from LotSerT where
		Crtd_Prog = @parm1 and
		RefNbr = @parm2 and
		InvtId = @parm3
      order by LotSerNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LotSerT_Prog_RefNbr_InvtId] TO [MSDSL]
    AS [dbo];

