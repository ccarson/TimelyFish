Create Proc InProjAllocLot_InvtId_LotSerNbr @parm1 varchar ( 30), @parm2 varchar (25), @parm3 varchar (10), @parm4 varchar (10) as
    Select * from InProjAllocLot where InvtId = @parm1
                  and LotSerNbr = @parm2
                  and SiteId = @parm3
                  and WhseLoc = @parm4
                  order by InvtId, LotSerNbr


