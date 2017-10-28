 Create Proc EDContainer_PPCtnsOnTare @CpnyId varchar(10), @ShipperId varchar(15), @TareId varchar(10) As
Select Count(*) From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId And TareId = @TareId And PackMethod = 'PP'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_PPCtnsOnTare] TO [MSDSL]
    AS [dbo];

