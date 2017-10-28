 CREATE proc  EDDataElement_Handling @parm1 VARCHAR(15)  AS Select  * from EDDataElement where segment = 'ITA' and position = '04' and code like @parm1 order by segment, position, code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_Handling] TO [MSDSL]
    AS [dbo];

