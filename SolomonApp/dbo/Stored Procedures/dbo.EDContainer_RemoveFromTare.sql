 Create Procedure EDContainer_RemoveFromTare @TareId varchar(10), @CpnyId varchar(10), @ShipperId varchar(15) As
Update EDContainer Set TareId = ' ' Where TareId = @TareId  And CpnyId = @CpnyId  And ShipperId = @ShipperId


