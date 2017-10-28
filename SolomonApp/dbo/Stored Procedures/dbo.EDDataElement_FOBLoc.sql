 CREATE proc EDDataElement_FOBLoc @Parm1 varchar(15) As Select  * From EDDataElement
Where Segment = 'FOB' And Position = '02' And Code Like @Parm1
Order By Segment, Position, Code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_FOBLoc] TO [MSDSL]
    AS [dbo];

