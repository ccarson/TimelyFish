 Create Proc EDSOLine_855Data @CpnyId varchar(10), @OrdNbr varchar(15) As
Select Count(*), Sum(QtyOrd), Max(PromDate) From SOLine Where CpnyId = @CpnyId And OrdNbr = @OrdNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOLine_855Data] TO [MSDSL]
    AS [dbo];

