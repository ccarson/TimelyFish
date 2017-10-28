 CREATE proc EDDataElement_PER01  @parm1 varchar(15)  AS Select  * from EDDataElement where segment = 'PER' and position = '01' and code like @parm1 order by segment, position, code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_PER01] TO [MSDSL]
    AS [dbo];

