Create Procedure baItemSite_Site @parm1 varchar (10) as 
    Select * from ItemSite Where SiteId = @parm1 
	Order by SiteId, InvtId

