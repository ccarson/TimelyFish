 CREATE proc EDDataElement_TranDirCode  @Parm1 varchar(15) As Select  * From EDDataElement
Where Segment = 'TD' And Position = '509' And Code Like @Parm1
Order By Segment, Position, Code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_TranDirCode] TO [MSDSL]
    AS [dbo];

