 Create Proc DropShipAutoCreate_Receipt_LIFO @InTranRecordID int As
  --Get the receipt number for the Receipt tied to the Sales Order where Sales Order is drop ship and auto create PO

  SELECT IC.*
    FROM InTran T JOIN SOShipLine SL
                    ON T.CpnyID = SL.CpnyID
                   and T.ShipperID = SL.ShipperID
                   and T.Shipperlineref = SL.LineRef
                JOIN POTranAlloc PTA
                    on SL.CpnyID = PTA.CpnyID
                   and SL.OrdNbr = PTA.SOOrdnbr
                   and SL.OrdLineRef = PTA.SOLineRef
                  JOIN POTran PT
                    on PT.RcptNbr = PTA.RcptNbr
                   and PT.LineRef = PTA.POTranLineRef
                  JOIN ItemCost IC
                    on T.Invtid = IC.InvtID
                   and T.SiteID = IC.SiteID
                   and T.LayerType = IC.LayerType
                   and PT.RcptNbr = IC.RcptNbr
                   and PT.RcptDate = IC.RcptDate
   WHERE T.Recordid = @InTranRecordID
   Order By PT.RcptDate Desc, PT.RcptNbr Desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DropShipAutoCreate_Receipt_LIFO] TO [MSDSL]
    AS [dbo];

