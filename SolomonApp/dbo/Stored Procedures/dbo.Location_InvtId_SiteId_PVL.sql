 /****** Object:  Stored Procedure dbo. Location_InvtId_SiteId_PVL Script Date: 4/17/98 10:58:18 AM ******/
Create Proc Location_InvtId_SiteId_PVL @parm1 varchar ( 30), @parm2 varchar ( 10) as
        Select * from Location where InvtId = @parm1
                                and  SiteId = @parm2
                                order by InvtId, SiteId, WhseLoc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Location_InvtId_SiteId_PVL] TO [MSDSL]
    AS [dbo];

