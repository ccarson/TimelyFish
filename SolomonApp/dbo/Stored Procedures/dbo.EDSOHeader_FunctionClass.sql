 Create Proc EDSOHeader_FunctionClass @FunctionId varchar(8), @ClassId varchar(4) As
Select CpnyId, OrdNbr From SOHeader Where NextFunctionId = @FunctionId And NextFunctionClass = @ClassId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOHeader_FunctionClass] TO [MSDSL]
    AS [dbo];

