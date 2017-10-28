 CREATE proc EDDataElement_TranLocQual  @Parm1 varchar(15) As Select  * From EDDataElement
Where Segment = 'TD' And Position = '507' And Code Like @Parm1
Order By Segment, Position, Code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_TranLocQual] TO [MSDSL]
    AS [dbo];

