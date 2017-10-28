 Create Proc EDContainerDet_Count @CpnyId varchar(10), @ShipperId varchar(15) As
Select Count(*) From EDContainerDet Where CpnyId = @CpnyId And ShipperId = @ShipperId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainerDet_Count] TO [MSDSL]
    AS [dbo];

