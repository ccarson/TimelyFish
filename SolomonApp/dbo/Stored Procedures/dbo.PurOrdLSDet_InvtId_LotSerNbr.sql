 /****** Object:  Stored Procedure dbo.PurOrdLSDet_InvtId_LotSerNbr                             ******/
Create Proc PurOrdLSDet_InvtId_LotSerNbr @parm1 varchar (30), @parm2 varchar (10), @parm3 varchar(25) as
       Select * from PurOrdLSDet
                Where InvtId = @parm1
                  and SiteId = @parm2
                  and LotSerNbr = @parm3



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdLSDet_InvtId_LotSerNbr] TO [MSDSL]
    AS [dbo];

