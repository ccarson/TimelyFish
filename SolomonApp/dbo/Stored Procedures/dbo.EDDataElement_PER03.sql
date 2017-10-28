 CREATE proc EDDataElement_PER03 @parm1 varchar(15) as select *  from EDDataElement where segment = 'PER' and position = '03' and code like @parm1 order by segment, position, code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_PER03] TO [MSDSL]
    AS [dbo];

