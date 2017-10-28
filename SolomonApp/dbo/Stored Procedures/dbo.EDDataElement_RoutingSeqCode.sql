 CREATE proc EDDataElement_RoutingSeqCode  @Parm1 varchar(15) As Select  * From EDDataElement
Where Segment = 'TD' And Position = '501' And Code Like @Parm1
Order By Segment, Position, Code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_RoutingSeqCode] TO [MSDSL]
    AS [dbo];

