
Create Proc [dbo].[ItemSite_InvtId_SiteID_Cpny] @parm1 varchar ( 30), @parm2 varchar ( 10), @parm3 varchar (10) as
        Select ItemSite.* from ItemSite
        JOIN Site on ItemSite.SiteID = Site.SiteId
        where InvtId = @parm1
			  and  ItemSite.SiteId = @parm2
			  and Site.CpnyID = @parm3 
                    order by ItemSite.InvtId, ItemSite.SiteId


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemSite_InvtId_SiteID_Cpny] TO [MSDSL]
    AS [dbo];

