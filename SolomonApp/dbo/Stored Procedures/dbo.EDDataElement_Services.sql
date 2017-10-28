 CREATE proc EDDataElement_Services @parm1 VARCHAR(15)  AS Select  * from EDDataElement where segment = 'ITA' and position = '03' and code like @parm1 order by segment, position, code


