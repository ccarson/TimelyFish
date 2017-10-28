 CREATE proc EDDataElement_Currency @parm1 varchar(15) AS Select  * from EDDataelement where segment = 'CUR' and position = '02' and code like @parm1 order by segment, position, code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_Currency] TO [MSDSL]
    AS [dbo];

