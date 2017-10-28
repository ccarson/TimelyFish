 CREATE proc EDDataElement_RoutingIdQul  @Parm1 varchar(15) As Select  * From EDDataElement
Where Segment = 'TD' And Position = '502' And Code Like @Parm1
Order By Segment, Position, Code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_RoutingIdQul] TO [MSDSL]
    AS [dbo];

