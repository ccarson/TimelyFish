 CREATE proc EDDataElement_Pos @Parm1 Varchar (5), @Parm2 Varchar(2) As
	Select distinct Position from EDDataElement WHERE Segment = @Parm1 AND Position LIKE @Parm2 order by Position



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_Pos] TO [MSDSL]
    AS [dbo];

