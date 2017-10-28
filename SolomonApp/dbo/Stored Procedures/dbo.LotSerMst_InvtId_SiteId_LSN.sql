 Create Proc LotSerMst_InvtId_SiteId_LSN @parm1 varchar ( 30), @parm2 varchar ( 10), @parm3 varchar (25) as
        Select * from LotSerMst where InvtId = @parm1
                                and  SiteId = @parm2
				and  LotSerNbr like @parm3
                                order by InvtId, SiteId, WhseLoc


