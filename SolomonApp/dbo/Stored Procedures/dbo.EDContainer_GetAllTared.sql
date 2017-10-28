 Create Proc EDContainer_GetAllTared @CpnyId varchar(10), @ShipperId varchar(15) As
Select * From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId And TareFlag = 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_GetAllTared] TO [MSDSL]
    AS [dbo];

