 CREATE Proc EDContainer_GetUnTared @CpnyId varchar(10), @ShipperId varchar(15) As
Select ContainerId From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId And TareFlag = 0 And TareId = ' ' Order By CpnyId, ShipperId, ContainerId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_GetUnTared] TO [MSDSL]
    AS [dbo];

