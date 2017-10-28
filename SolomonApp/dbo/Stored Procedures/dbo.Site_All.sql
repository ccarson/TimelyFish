 /****** Object:  Stored Procedure dbo.Site_All    Script Date: 4/17/98 10:58:19 AM ******/
/****** Object:  Stored Procedure dbo.Site_All    Script Date: 4/16/98 7:41:53 PM ******/
Create Proc Site_All @parm1 varchar ( 10) as
    Select * from Site where SiteId like @parm1 order by SiteId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Site_All] TO [MSDSL]
    AS [dbo];

