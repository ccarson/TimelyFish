 Create Proc EDSOHeader_Cancel @CpnyId varchar(10), @OrdNbr varchar(15) As
Update SOHeader Set Cancelled = 1, CancelDate = GetDate() Where CpnyId = @CpnyId And OrdNbr = @OrdNbr


