 CREATE Proc StdCost_Inventory_All_NoKits @parm1 varchar ( 30)
AS

SELECT i.*
  FROM Inventory i LEFT OUTER JOIN Kit k
                   ON i.InvtID = k.KitID
 WHERE i.InvtId like @parm1
   AND k.KitID IS NULL
   AND TranStatusCode <> 'IN'
 ORDER by i.InvtID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[StdCost_Inventory_All_NoKits] TO [MSDSL]
    AS [dbo];

