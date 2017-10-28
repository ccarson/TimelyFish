 CREATE Proc EDDataElement_SegPos @Segment varchar(5), @Position varchar(2), @Code varchar(15) As
Select * From EDDataElement Where Segment = @Segment And Position = @Position And Code Like @Code
Order By Segment, Position, Code


