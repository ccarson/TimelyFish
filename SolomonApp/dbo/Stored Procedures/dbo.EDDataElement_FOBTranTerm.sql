 CREATE proc EDDataElement_FOBTranTerm @Parm1 varchar(15) As Select  * From EDDataElement
Where Segment = 'FOB' And Position = '05' And Code Like @Parm1
Order By Segment, Position, Code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_FOBTranTerm] TO [MSDSL]
    AS [dbo];

