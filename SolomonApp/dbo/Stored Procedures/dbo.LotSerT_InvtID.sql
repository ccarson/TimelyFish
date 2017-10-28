 /****** Object:  Stored Procedure dbo.LotSerT_InvtID    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.LotSerT_InvtID    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc LotSerT_InvtID @parm1 varchar (30) as
    Select * from LotSerT where InvtID = @parm1
                order by LotSerNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LotSerT_InvtID] TO [MSDSL]
    AS [dbo];

