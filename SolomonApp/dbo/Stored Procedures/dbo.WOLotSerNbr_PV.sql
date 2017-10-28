 Create Proc WOLotSerNbr_PV @parm1 varchar ( 30), @parm2 varchar (10), @parm3 varchar (10), @parm4 varchar (25) as
    Select * from LotSerMst where InvtId = @parm1
                  and SiteId = @parm2
                  and WhseLoc = @parm3
                  and lotsernbr like @Parm4
                  and Status = 'A'
                  and QtyOnHand > 0
                  and (expDate >= getdate() or expDate = '1900-01-01 00:00:00')
                  order by InvtId, SiteID, WhseLoc, LotSerNbr


