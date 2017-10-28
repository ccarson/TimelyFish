 Create Procedure EDContainer_AddToTare @CpnyId varchar(10), @ShipperId varchar(15), @TareId varchar(10) As
Update EDContainer Set TareId = @TareId Where CpnyId = @CpnyId And ShipperId = @ShipperId And
TareFlag = 0 And LTrim(TareId) = ''



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_AddToTare] TO [MSDSL]
    AS [dbo];

