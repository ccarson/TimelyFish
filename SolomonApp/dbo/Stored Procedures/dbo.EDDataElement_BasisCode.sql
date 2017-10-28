 CREATE proc EDDataElement_BasisCode @parm1 varchar(15)  AS Select  * from EDDataElement where segment = 'ITD' and position = '02' and code like @parm1 order by segment, position, code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_BasisCode] TO [MSDSL]
    AS [dbo];

