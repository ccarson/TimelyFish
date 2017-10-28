 Create Proc EDCommQual_Description @Parm1 varchar(2) As Select Description From EDCommQual
Where CommId = @Parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDCommQual_Description] TO [MSDSL]
    AS [dbo];

