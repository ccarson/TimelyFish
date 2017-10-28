 Create proc EDI_DataElement_Purpose @parm1 varchar(15) AS Select  * from  EDDataelement where segment = 'BEG' and position = '01' and code like @parm1 order by segment, position, code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDI_DataElement_Purpose] TO [MSDSL]
    AS [dbo];

