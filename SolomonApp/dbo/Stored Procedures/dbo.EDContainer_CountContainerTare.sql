 CREATE Proc EDContainer_CountContainerTare @CpnyId varchar(10), @ShipperId varchar(15) As
Select Cast(Sum(Case TareFlag When 1 Then 0 Else 1 End) As int),
Cast(Sum(Case TareFlag When 1 Then 1 Else 0 End) As int)
From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId


