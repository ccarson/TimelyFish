Create Procedure baItemSite_ItemSite @parm1 varchar (30), @parm2 varchar (10) as 
    Select  * from ItemSite Where InvtId = @parm1 and SiteId = @parm2
	Order by InvtId, SiteId

