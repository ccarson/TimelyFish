 CREATE Proc EDTransaction_Description @Parm1 varchar(3), @Parm2 varchar(1) As Select Description
From EDTransaction Where Trans = @Parm1 And Direction = @Parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDTransaction_Description] TO [MSDSL]
    AS [dbo];

