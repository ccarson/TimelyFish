 Create Proc EDContainer_GetTared @CpnyId varchar(10), @ShipperId varchar(15) As
Select ContainerId From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId And TareFlag = 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_GetTared] TO [MSDSL]
    AS [dbo];

