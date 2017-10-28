 CREATE proc EDDataElement_TranMethCode  @Parm1 varchar(15) As Select  * From EDDataElement
Where Segment = 'TD' And Position = '504' And Code Like @Parm1
Order By Segment, Position, Code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_TranMethCode] TO [MSDSL]
    AS [dbo];

