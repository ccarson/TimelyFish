 Create Proc EDContainer_OneContainer @CpnyId varchar(10), @ShipperId varchar(15), @ContainerId varchar(10) As
Select * From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId And ContainerId = @ContainerId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_OneContainer] TO [MSDSL]
    AS [dbo];

