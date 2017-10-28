/****** Object:  Stored Procedure dbo.SITEGROUP_CPNYID    Script Date: 01/03/08 7:41:53 PM ******/
CREATE Proc SITEGROUP_CPNYID 
    @parm1 varchar ( 10), @parm2 varchar(10) 
AS
    SELECT * 
      FROM SiteGroup 
     WHERE CpnyID = @parm1 and SiteGroupId like @parm2 
     ORDER BY CpnyID, SiteGroupId


GO
GRANT CONTROL
    ON OBJECT::[dbo].[SITEGROUP_CPNYID] TO [MSDSL]
    AS [dbo];

