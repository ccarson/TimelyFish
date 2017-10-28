 Create Proc BM_LotSerT_CpnyId_Prog_RefNbr @CpnyId varchar (10), @Prog varchar (8), @RefNbr varchar (15) as
    	Select * from LotSerT where
		CpnyId = @CpnyId and
		Crtd_Prog = @Prog and
		RefNbr = @RefNbr
        Order By LotSerNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BM_LotSerT_CpnyId_Prog_RefNbr] TO [MSDSL]
    AS [dbo];

