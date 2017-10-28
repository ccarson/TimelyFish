 Create Proc LotSerT_InvtID_LotSerNbr_Btwn @parm1 varchar (30), @parm2 varchar (25), @Parm3 varchar (25) as
    	Select * from LotSerT where
		InvtID = @parm1 and
		LotSerNbr >= @parm2 and
		LotSerNbr <= @Parm3
                order by LotSerNbr


