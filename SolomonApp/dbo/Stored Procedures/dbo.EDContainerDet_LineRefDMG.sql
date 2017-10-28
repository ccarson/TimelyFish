 CREATE proc EDContainerDet_LineRefDMG @parm1 varchar(30),@parm2 varchar(5) as
Select * from edcontainerdet where invtid = @parm1  and  lineref like @parm2 order by lineref



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainerDet_LineRefDMG] TO [MSDSL]
    AS [dbo];

