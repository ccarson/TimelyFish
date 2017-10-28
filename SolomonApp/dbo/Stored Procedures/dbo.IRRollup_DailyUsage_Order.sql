 Create procedure IRRollup_DailyUsage_Order
As
Update Itemsite
Set IrDailyUsage = i.Irdailyusage + x.irdailyusage2, reordqty = i.reordqty + x.reordqty2
  FROM ItemSite i JOIN Inventory y
                    ON i.Invtid = y.InvtID
                  INNER JOIN (SELECT t.InvtiD, t.irtransfersiteid, Sum(irdailyusage) irdailyusage2,Sum(reordqty) reordqty2
                                FROM ItemSite t
                               GROUP BY t.InvtID,t.irtransfersiteid) x
                     ON x.InvtID = i.InvtID
                    AND x.irtransfersiteID = i.SiteID
 WHERE y.StkItem = 1
   AND y.transtatuscode NOT IN ('IN','NP')


