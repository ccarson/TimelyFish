 /****** Object:  Stored Procedure dbo.LotSerMst_InvtId_MfgrLotSerNbr                           ******/
Create Proc LotSerMst_InvtId_MfgrLotSerNbr @parm1 varchar ( 30), @parm2 varchar (25), @parm3 varchar (10), @parm4 varchar (10) as
    Select * from LotSerMst where InvtId = @parm1
                  and MfgrLotSerNbr = @parm2
                  and SiteId = @parm3
                  and WhseLoc = @parm4
                  order by InvtId, MfgrLotSerNbr


