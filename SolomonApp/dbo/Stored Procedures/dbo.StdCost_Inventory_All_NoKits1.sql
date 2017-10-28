 CREATE Proc StdCost_Inventory_All_NoKits1 @parm1 varchar ( 30)
AS

SELECT I.*
  FROM Inventory i LEFT OUTER JOIN Kit k
                   ON i.InvtID = k.KitID
 WHERE i.InvtId like @parm1
   AND i.ValMthd = 'T' AND k.KitID IS NULL
   AND i.TranStatusCode <> 'IN'
   AND (i.PstdCost <> 0 OR EXISTS (SELECT InvtID
                                            FROM ItemSite s
                                           WHERE s.InvtID = i.InvtID
                                             AND s.PstdCst <> 0))
 ORDER by i.InvtID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[StdCost_Inventory_All_NoKits1] TO [MSDSL]
    AS [dbo];

