 Create Proc LotSerMst_InvtId_SiteId_Whse @parm1 varchar ( 24), @parm2 varchar ( 10), @parm3 varchar ( 10) as
        Select * from LotSerMst where InvtId = @parm1
                                and  SiteId = @parm2
                                and Whseloc Like @parm3
            order by InvtId, SiteId, LotSerNbr, WhseLoc


