 Create Proc EDSOType_Description @SOTypeId varchar(4) As
Select Descr From SOType Where SOTypeId = @SOTypeId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOType_Description] TO [MSDSL]
    AS [dbo];

