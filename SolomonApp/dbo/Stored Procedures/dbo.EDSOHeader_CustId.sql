 Create Proc EDSOHeader_CustId @CpnyId varchar(10), @OrdNbr varchar(15) As
Select CustId From SOHeader Where CpnyId = @CpnyId And OrdNbr = @OrdNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOHeader_CustId] TO [MSDSL]
    AS [dbo];

