 /****** Object:  Stored Procedure dbo.LotSerT_LotSerNbr_TranDate    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.LotSerT_LotSerNbr_TranDate    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc LotSerT_LotSerNbr_TranDate @parm1 varchar ( 30), @parm2 varchar (25), @parm3 smalldatetime, @parm4 smalldatetime as
        Select * from LotSerT where InvtId = @parm1
	            and LotSerNbr = @parm2
                    and TranDate >= @parm3
                    and TranDate <= @parm4
                    order by InvtId, LotSerNbr, TranDate


