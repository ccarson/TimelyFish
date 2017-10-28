 CREATE Proc EDSOHeader_Update @AccessNbr smallint As
Update EDSOHeader Set AgreeNbr = C.AgreeNbr, ArrivalDate = C.ArrivalDate, BatchNbr = C.BatchNbr,
  BidNbr = C.BidNbr, CancelDate = C.CancelDate, DeliveryDate = C.DeliveryDate, PromoNbr = C.PromoNbr,
  QuoteNbr = C.QuoteNbr, RequestedDate = C.RequestDate, SalesRegion = C.SalesRegion,
  ScheduledDate = C.ScheduleDate, ShipNBDate = C.ShipNBDate, ShipNLDate = C.ShipNLDate,
  ShipWeekOf = C.ShipWeekOf, FOBTranType = D.TranMethCode, ShipMthPay = D.FOBShipMeth,
  FOBLocQual = ISNULL(NULLIF(D.TranLocQual,''),D.FOBLocQual) From EDSOHeader A Inner Join SOHeader B On A.CpnyId = B.CpnyId
  And A.OrdNbr = B.OrdNbr Inner Join ED850HeaderExt C On B.CpnyId = C.CpnyId And
  B.EDIPOID = C.EDIPOID Inner Join ED850Header D On B.CpnyId = D.CpnyId And B.EDIPOID =
  D.EDIPOID Where C.EDIPOID In (Select EDIPOID From EDWrkPOToSO Where AccessNbr =
  @AccessNbr)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOHeader_Update] TO [MSDSL]
    AS [dbo];

