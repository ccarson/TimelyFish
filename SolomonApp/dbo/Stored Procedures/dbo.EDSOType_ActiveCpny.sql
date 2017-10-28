 Create Proc EDSOType_ActiveCpny @CpnyId varchar(10), @SOTypeId varchar(4) As
Select * From SOType Where CpnyId Like @CpnyId And Active = 1 And SOTypeId Like @SOTypeId
Order By SOTypeId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOType_ActiveCpny] TO [MSDSL]
    AS [dbo];

