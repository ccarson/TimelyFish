﻿ /****** Object:  Stored Procedure dbo.LotSerMst_InvtId_LotSerNbr    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.LotSerMst_InvtId_LotSerNbr    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc LotSerMst_InvtId_LotSerNbr @parm1 varchar ( 30), @parm2 varchar (25), @parm3 varchar (10), @parm4 varchar (10) as
    Select * from LotSerMst where InvtId = @parm1
                  and LotSerNbr = @parm2
                  and SiteId = @parm3
                  and WhseLoc = @parm4
                  order by InvtId, LotSerNbr

