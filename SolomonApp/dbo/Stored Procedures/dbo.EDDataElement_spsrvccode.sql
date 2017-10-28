 CREATE proc EDDataElement_spsrvccode  @Parm1 varchar(15) As Select  * From EDDataElement
Where Segment = 'SSS' And Position = '03' And Code Like @Parm1
Order By Segment, Position, Code


