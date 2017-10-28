 /****** Object:  Stored Procedure dbo.ItemSite_All    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.ItemSite_All    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc ItemSite_All @parm1 varchar ( 30) As
    Select * from itemsite
            Where Invtid = @parm1
            Order by SiteId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemSite_All] TO [MSDSL]
    AS [dbo];

