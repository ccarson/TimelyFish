 /****** Object:  Stored Procedure dbo.LotSerT_MfgrLotSerNbr_TranType    Script Date: 4/17/98 10:58:19 AM ******/
/****** Object:  Stored Procedure dbo.LotSerT_MfgrLotSerNbr_TranType    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc LotSerT_MfgrLotSerNbr_TranType @parm1 varchar (30), @parm2 varchar (25), @parm3 varchar (2) as
    Select * from LotSerT where InvtID = @parm1
		and MfgrLotSerNbr = @parm2
	        and TranType = @parm3
                order by LotSerNbr


