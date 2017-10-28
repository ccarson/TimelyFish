 CREATE Proc EDItemXRef_FindRef @CpnyId varchar(10), @ShipperId varchar(15), @EntityId varchar(15), @AlternateId varchar(30) As
Select Count(*), Max(InvtId) From SOShipLine Where CpnyId = @CpnyId And ShipperId = @ShipperId And
(Select Count(*) From ItemXRef Where ItemXRef.InvtId = SOShipLine.InvtId And AlternateId = @AlternateId And EntityId In (@EntityId, '*')) = 1


