 /****** Object:  Stored Procedure dbo.LotSerT_MfgLotSerNbr_Type_Date    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.LotSerT_MfgLotSerNbr_Type_Date    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc LotSerT_MfgLotSerNbr_Type_Date @parm1 varchar (30), @parm2 varchar (25), @parm3 varchar (2) , @parm4 smalldatetime, @parm5 smalldatetime as
    Select * from LotSerT where InvtID = @parm1
		and MfgrLotSerNbr = @parm2
	        and TranType = @parm3
                and TranDate >= @parm4
                and TranDate <= @parm5
                order by LotSerNbr


