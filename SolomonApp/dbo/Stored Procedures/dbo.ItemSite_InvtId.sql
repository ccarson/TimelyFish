 /****** Object:  Stored Procedure dbo.ItemSite_InvtId    Script Date: 4/17/98 10:58:18 AM ******/
Create Proc ItemSite_InvtId @parm1 varchar ( 30) as
        Select * from ItemSite where InvtId = @parm1
                    order by InvtId, SiteId


