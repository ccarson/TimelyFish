 CREATE Proc EDContainer_GetAllUnTared @CpnyId varchar(10), @ShipperId varchar(15) As
Select * From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId And TareFlag = 0 And LTrim(TareId) = ''



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_GetAllUnTared] TO [MSDSL]
    AS [dbo];

