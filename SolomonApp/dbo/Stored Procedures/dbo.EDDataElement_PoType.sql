 Create proc EDDataElement_PoType @parm1 varchar(15)  AS Select  * from EDDataelement where segment = 'BEG' and position = '02' and code like @parm1 order by segment, position, code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_PoType] TO [MSDSL]
    AS [dbo];

