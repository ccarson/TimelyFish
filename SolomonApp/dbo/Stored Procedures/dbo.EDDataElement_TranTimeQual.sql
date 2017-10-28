 CREATE proc EDDataElement_TranTimeQual  @Parm1 varchar(15) As Select  * From EDDataElement
Where Segment = 'TD' And Position = '510' And Code Like @Parm1
Order By Segment, Position, Code


