
CREATE Proc [dbo].[StdCost_Inventory_Site_Cpny_NoKits1] @parm1 varchar ( 30), @parm2 varchar( 10), @parm3 varchar (10)
    AS

    SELECT I.*
      FROM Inventory i Inner JOIN ITEMSITE s
                               on i.InvtID = s.InvtID
                       Inner JOIN Site
							   on Site.SiteId = s.SiteID
                       LEFT OUTER JOIN Kit k
                                    ON i.InvtID = k.KitID
       WHERE i.InvtId like @parm1
       AND s.SiteId like @parm2
       AND Site.CpnyID = @parm3 
       AND i.ValMthd = 'T' AND k.KitID IS NULL
       AND i.TranStatusCode <> 'IN'
       AND (i.PstdCost <> 0 OR EXISTS (SELECT InvtID
                                                FROM ItemSite s
                                                Inner JOIN Site on Site.SiteId = s.SiteID
                                               WHERE s.InvtID = i.InvtID
												 AND Site.CpnyID = @parm3
                                                 AND s.PstdCst <> 0))
     ORDER by i.InvtID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[StdCost_Inventory_Site_Cpny_NoKits1] TO [MSDSL]
    AS [dbo];

