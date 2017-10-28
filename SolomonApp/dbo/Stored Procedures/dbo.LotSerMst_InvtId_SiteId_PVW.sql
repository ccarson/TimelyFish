 Create Proc LotSerMst_InvtId_SiteId_PVW @parm1 varchar ( 24), @parm2 varchar ( 10), @parm3 varchar ( 15), @parm4 varchar ( 10) as
        Select * from LotSerMst where InvtId = @parm1
                                and  SiteId = @parm2
                                and LotSerNbr = @parm3
                                and Whseloc Like @parm4
            order by InvtId, SiteId, LotSerNbr, WhseLoc


