 CREATE proc EDDataElement_Indicator  @Parm1 varchar(15) As Select  * From EDDataElement
Where Segment = 'SSS' And Position = '01' And Code Like @Parm1
Order By Segment, Position, Code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_Indicator] TO [MSDSL]
    AS [dbo];

