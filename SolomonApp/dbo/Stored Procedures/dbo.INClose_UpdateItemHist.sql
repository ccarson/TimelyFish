 CREATE proc INClose_UpdateItemHist @FiscalYr AS VARCHAR(4), @NextFiscalYr AS VARCHAR(4) As

UPDATE H
SET BegBal = BegBal - Extcost from ItemHist H INNER JOIN
   (SELECT Extcost = SUM(I.ExtCost), I.InvtId, I.SiteId, I.FiscYr
      FROM InTran  I INNER JOIN Inventory  Y
                        ON I.InvtId = Y.InvtId
                     LEFT OUTER JOIN SOShipHeader s WITH(NOLOCK)
                        ON I.ShipperID = s.ShipperID
                       AND I.CpnyID = s.CpnyID
     WHERE (I.Trantype = 'CM' AND I.S4Future09 = 1 AND
	    Y.StkItem = 1 AND  I.Fiscyr = @FiscalYr AND ISNULL(s.DropShip,0) = 0)
     GROUP BY I.Invtid, I.SiteId, I.Fiscyr) I
on H.InvtId = I.InvtId and H.SiteId = I.SiteId and H.Fiscyr = @NextFiscalYr

UPDATE T
SET BegQty = BegQty - Qty from Item2Hist T INNER JOIN
   (SELECT Qty = SUM(I.Qty), I.InvtId, I.SiteId, I.Fiscyr
      FROM InTran  I INNER JOIN Inventory  Y
                        ON I.InvtId = Y.InvtId
                     LEFT OUTER JOIN SOShipHeader s WITH(NOLOCK)
                        ON I.ShipperID = s.ShipperID
                       AND I.CpnyID = s.CpnyID
     WHERE (I.Trantype = 'CM' AND I.S4Future09 = 1 AND
	    Y.StkItem = 1 AND  I.FiscYr = @FiscalYr AND ISNULL(s.DropShip,0) = 0)
     GROUP BY I.InvtId, I.SiteId, I.Fiscyr) I
on T.InvtId = I.InvtId and T.SiteId = I.SiteId and T.Fiscyr = @NextFiscalYr


