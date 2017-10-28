 /****** Object:  Stored Procedure dbo.LotSerT_InvtID_TranDate    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.LotSerT_InvtID_TranDate    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc LotSerT_InvtID_TranDate @parm1 varchar ( 30), @parm2 smalldatetime, @parm3 smalldatetime as
        Select * from LotSerT where InvtId = @parm1
                    and TranDate >= @parm2
                    and TranDate <= @parm3
                    order by InvtId, TranDate


