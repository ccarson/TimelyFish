 CREATE proc EDDataElement_Qualifier @parm1 varchar(15) AS Select  * from EDDataElement where segment = 'ITA' and position = '08' and code like @parm1 order by segment, position, code


