 Create Proc Kit_Kitid_Site53_PendingCst @parm1 varchar ( 30), @parm2 varchar ( 10) as
        SELECT k.*
          FROM Kit k JOIN Inventory i
                       ON k.KitID = i.InvtID
         WHERE k.Kitid like @parm1
	   AND k.Siteid like @parm2
           AND k.Status = 'A'
           AND KitType = 'B'
           AND I.ValMthd = 'T'
           AND k.PstdCst <> 0
        Order by k.Kitid, k.Siteid, k.Status


