 Create Proc EDSOHeader_OrdersForEDIPO @CpnyId varchar(10), @EDIPOID varchar(10) As
Select OrdNbr From SOHeader Where CpnyId = @CpnyId And EDIPOID = @EDIPOID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOHeader_OrdersForEDIPO] TO [MSDSL]
    AS [dbo];

