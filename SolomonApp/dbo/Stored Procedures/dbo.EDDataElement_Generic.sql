 CREATE Proc EDDataElement_Generic @Parm1 char(5), @parm2 char(2), @parm3 char(15) As
select * from EDDataElement where Segment = @parm1 and Position = @parm2 and code like @parm3 order by Segment, Position, code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_Generic] TO [MSDSL]
    AS [dbo];

