 /****** Object:  Stored Procedure dbo.Location_InvtId_SiteId_    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.Location_InvtId_SiteId_    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc Location_InvtId_SiteId_ @parm1 varchar ( 30), @parm2 varchar ( 10), @parm3 varchar ( 10) as
        Select * from Location where InvtId = @parm1
                                and  SiteId = @parm2
                                and WhseLoc = @parm3
                    order by InvtId, SiteId, WhseLoc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Location_InvtId_SiteId_] TO [MSDSL]
    AS [dbo];

