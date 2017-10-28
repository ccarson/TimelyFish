 CREATE proc EDDataElement_TermsType @parm1 varchar(15)  AS Select  * from EDDataElement where segment = 'ITD' and position = '01' and code like @parm1 order by segment, position, code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_TermsType] TO [MSDSL]
    AS [dbo];

