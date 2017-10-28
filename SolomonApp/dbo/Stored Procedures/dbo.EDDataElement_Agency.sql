 CREATE proc EDDataElement_Agency @parm1 varchar(15)  AS Select  * from EDDataElement where segment = 'ITA' and position = '02' and code like @parm1 order by segment, position, code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_Agency] TO [MSDSL]
    AS [dbo];

