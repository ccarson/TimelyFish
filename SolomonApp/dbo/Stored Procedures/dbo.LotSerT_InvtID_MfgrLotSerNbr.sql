 /****** Object:  Stored Procedure dbo.LotSerT_InvtID_MfgrLotSerNbr    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.LotSerT_InvtID_MfgrLotSerNbr    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc LotSerT_InvtID_MfgrLotSerNbr @parm1 varchar (30), @parm2 varchar (25)  as
    Select * from LotSerT where InvtID = @parm1
	        and MfgrLotSerNbr = @parm2
                order by LotSerNbr


