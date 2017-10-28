
 Create Proc [dbo].[Kit_Kitid_CpnySite53_PendingCst] @parm1 varchar ( 30), @parm2 varchar ( 10), @parm3 varchar (10) as
        SELECT k.*
          FROM Kit k JOIN Inventory i
                       ON k.KitID = i.InvtID
                     JOIN Site s
					   ON k.SiteID = s.SiteId
         WHERE k.Kitid like @parm1
	   AND k.Siteid like @parm2
	   AND s.CpnyID = @parm3
           AND k.Status = 'A'
           AND KitType = 'B'
           AND I.ValMthd = 'T'
           AND k.PstdCst <> 0
        Order by k.Kitid, k.Siteid, k.Status

GO
GRANT CONTROL
    ON OBJECT::[dbo].[Kit_Kitid_CpnySite53_PendingCst] TO [MSDSL]
    AS [dbo];

