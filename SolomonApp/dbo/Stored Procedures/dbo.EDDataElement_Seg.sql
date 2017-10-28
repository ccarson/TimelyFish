 CREATE proc EDDataElement_Seg @Parm1 Varchar (5) As
	Select distinct Segment from EDDataElement WHERE Segment LIKE @Parm1 order by segment


