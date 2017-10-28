 Create Proc EDSOHeader_CpnyIdOrdNbr @CpnyId varchar(10), @OrdNbr varchar(15) As
Select * From EDSOHeader Where CpnyId = @CpnyId And OrdNbr = @OrdNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOHeader_CpnyIdOrdNbr] TO [MSDSL]
    AS [dbo];

