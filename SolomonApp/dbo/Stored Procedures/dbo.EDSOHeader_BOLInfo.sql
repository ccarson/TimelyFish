 CREATE Proc EDSOHeader_BOLInfo @CpnyId varchar(10), @ShipperId varchar(15) As
Select CrossDock, Pro From EDSOHeader A, SOShipHeader B Where A.CpnyId = B.CpnyId And A.OrdNbr = B.OrdNbr And B.ShipperId = @ShipperId


