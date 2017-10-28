
Create Proc [dbo].[ItemSite_InvtId_Cpny] @parm1 varchar ( 30), @parm2 varchar (10) as
        Select ItemSite.* from ItemSite
        JOIN Site on ItemSite.SiteID = Site.SiteId
        where InvtId = @parm1
        and Site.CpnyID = @parm2 
        order by ItemSite.InvtId, ItemSite.SiteId


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemSite_InvtId_Cpny] TO [MSDSL]
    AS [dbo];

