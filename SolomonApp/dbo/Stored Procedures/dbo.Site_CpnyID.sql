 /****** Object:  Stored Procedure dbo.Site_CpnyID    Script Date: 4/17/98 10:58:19 AM ******/
/****** Object:  Stored Procedure dbo.Site_CpnyID    Script Date: 4/16/98 7:41:53 PM ******/
Create Proc Site_CpnyID @parm1 varchar ( 10), @parm2 varchar(10) as
    Select * from Site where CpnyID = @parm1 and SiteId like @parm2 order by CpnyID, SiteId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Site_CpnyID] TO [MSDSL]
    AS [dbo];

