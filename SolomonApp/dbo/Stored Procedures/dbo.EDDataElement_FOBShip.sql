 Create proc EDDataElement_FOBShip @Parm1 varchar(15) As Select  * From EDDataElement
Where Segment = 'FOB' And Position = '01' And Code Like @Parm1
Order By Segment, Position, Code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_FOBShip] TO [MSDSL]
    AS [dbo];

