 /****** Object:  Stored Procedure dbo.EDDataElement_All    Script Date: 5/28/99 1:17:41 PM ******/
CREATE PROCEDURE EDDataElement_AllDMG @parm1 varchar(5), @parm2 varchar(2), @parm3 varchar(15) AS
select * from EDDataElement
where Segment like @parm1
and Position Like @parm2
and code like @parm3
order by Segment, Position, code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDDataElement_AllDMG] TO [MSDSL]
    AS [dbo];

