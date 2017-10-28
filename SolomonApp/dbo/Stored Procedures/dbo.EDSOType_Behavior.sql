 Create Proc EDSOType_Behavior @CpnyId varchar(10), @SOTypeId varchar(4) As
Select Behavior From SOType Where CpnyId = @CpnyId And SOTypeId = @SOTypeId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOType_Behavior] TO [MSDSL]
    AS [dbo];

