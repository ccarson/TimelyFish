 /****** Object:  Stored Procedure dbo.LotSerT_InvtID_TranType    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.LotSerT_InvtID_TranType    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc LotSerT_InvtID_TranType @parm1 varchar (30), @parm2 varchar (2) as
    Select * from LotSerT where InvtID = @parm1
	        and TranType = @parm2
                order by LotSerNbr


