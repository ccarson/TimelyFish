 /****** Object:  Stored Procedure dbo.LotSerNbr_PV    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo. LotSerNbr_PV Script Date: 4/16/98 7:41:52 PM ******/
Create Proc LotSerNbr_PV @parm1 varchar ( 30), @parm2 varchar (10), @parm3 varchar (10), @parm4 varchar (25) as
    Select * from LotSerMst where InvtId = @parm1
                  and SiteId = @parm2
                  and WhseLoc = @parm3
                  and lotsernbr like @Parm4
                  and Status = 'A'
                  and QtyOnHand > 0
                  order by InvtId, SiteID, WhseLoc, LotSerNbr


