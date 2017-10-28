 Create Proc EDSOHeader_Purge As
Delete From EDSOHeader Where Not Exists (Select * From SOHeader Where EDSOHeader.CpnyId =
SOHeader.CpnyId And EDSOHeader.OrdNbr = SOHeader.OrdNbr)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOHeader_Purge] TO [MSDSL]
    AS [dbo];

