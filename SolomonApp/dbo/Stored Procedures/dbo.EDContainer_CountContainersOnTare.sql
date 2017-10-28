 Create Proc EDContainer_CountContainersOnTare @CpnyId varchar(10), @ShipperId varchar(15), @TareId varchar(10) As
Select Cast(Sum(Case PackMethod When 'PP' Then 1 Else 0 End) As int), Count(*)
From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId And TareId = @TareId


