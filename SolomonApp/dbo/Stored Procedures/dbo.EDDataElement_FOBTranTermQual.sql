 CREATE proc EDDataElement_FOBTranTermQual  @Parm1 varchar(15) As Select  * From EDDataElement
Where Segment = 'FOB' And Position = '04' And Code Like @Parm1
Order By Segment, Position, Code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_FOBTranTermQual] TO [MSDSL]
    AS [dbo];

