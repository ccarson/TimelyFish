 CREATE Proc EDContainer_OnTare @CpnyId varchar(10), @ShipperId varchar(15), @TareId varchar(10) As
Select ContainerId From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId And TareId = @TareId Order By CpnyId, ShipperId, ContainerId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_OnTare] TO [MSDSL]
    AS [dbo];

