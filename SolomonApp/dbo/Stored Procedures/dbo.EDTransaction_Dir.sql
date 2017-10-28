 CREATE Proc EDTransaction_Dir @Parm1 varchar(1), @Parm2 varchar(3) As Select *
From EDTransaction Where Direction = @Parm1 And Trans Like @Parm2
Order By Trans



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDTransaction_Dir] TO [MSDSL]
    AS [dbo];

