
 Create Proc [dbo].[Kit_Kitid_CpnySiteId_Status] @parm1 varchar ( 30), @parm2 varchar ( 10), @parm3 varchar ( 1), @parm4 varchar (10) as
	Select k.* from Kit k
		JOIN Site s on k.SiteID = s.SiteId
        where k.KitId = @parm1
		and k.SiteID = @parm2
		and k.Status = @parm3
		and s.CpnyID = @parm4
		order by k.KitId, k.SiteID, k.Status


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Kit_Kitid_CpnySiteId_Status] TO [MSDSL]
    AS [dbo];

