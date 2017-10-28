Create Proc LotSerNbr_PV_NoProjInv @parm1 varchar ( 30), @parm2 varchar (10), @parm3 varchar (10), @parm4 varchar (25) as
    Select * from LotSerMst where InvtId = @parm1
                  and SiteId = @parm2
                  and WhseLoc = @parm3
                  and lotsernbr like @Parm4
                  and Status = 'A'
                  and (QtyOnHand - QtyAllocProjIN) > 0
                  order by InvtId, SiteID, WhseLoc, LotSerNbr


