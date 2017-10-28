 CREATE PROCEDURE EDContainer_Count_Shipperid @CpnyId varchar(10), @ShipperId varchar(15) As
Select Count(*)
From EDContainer
Where  CpnyId = @CpnyId And ShipperId = @ShipperId


