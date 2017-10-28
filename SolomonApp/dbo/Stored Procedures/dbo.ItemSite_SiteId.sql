 /****** Object:  Stored Procedure dbo.ItemSite_SiteId    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.ItemSite_SiteId    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc ItemSite_SiteId @parm1 varchar ( 10) as
    Select * from ItemSite where SiteId = @parm1 order by SiteId


