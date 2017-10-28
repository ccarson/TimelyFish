 /****** Object:  Stored Procedure dbo.LotSerT_BatNbr    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.LotSerT_BatNbr    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc LotSerT_BatNbr @parm1 varchar (2), @parm2 varchar ( 10), @parm3 varchar ( 30) as
    Select * from LotSerT where TranSrc = @parm1
                  and Batnbr = @parm2
                  and KitID = @parm3
                  order by TranSrc,BatNbr,KitID,INTranLineId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LotSerT_BatNbr] TO [MSDSL]
    AS [dbo];

