 Create Proc ItemSite_InvtId_SiteId1 @parm1 varchar ( 30), @parm2 varchar ( 10) as
        Select ItemSite.*, Site.*
			from ItemSite
				left outer join Site
					on ItemSite.SiteId = Site.SiteId
			where ItemSite.InvtId = @parm1 and
                ItemSite.SiteId like @parm2
            order by ItemSite.InvtId, ItemSite.SiteId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemSite_InvtId_SiteId1] TO [MSDSL]
    AS [dbo];

