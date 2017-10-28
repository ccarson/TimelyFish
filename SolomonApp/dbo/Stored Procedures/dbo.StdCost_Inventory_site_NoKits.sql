 CREATE Proc StdCost_Inventory_site_NoKits @parm1 varchar ( 30), @parm2 varchar( 10)
AS

SELECT i.*
  FROM Inventory i Inner JOIN ITEMSITE s
                           on i.InvtID = s.InvtID
                   LEFT OUTER JOIN Kit k
                                ON i.InvtID = k.KitID

 WHERE i.InvtId like @parm1
   AND s.SiteId = @parm2
   AND k.KitID IS NULL
   AND TranStatusCode <> 'IN'
 ORDER by i.InvtID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[StdCost_Inventory_site_NoKits] TO [MSDSL]
    AS [dbo];

