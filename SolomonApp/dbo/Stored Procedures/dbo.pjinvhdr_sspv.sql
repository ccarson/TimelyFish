 Create Procedure pjinvhdr_sspv @parm1 varchar (16) , @parm2 varchar (10)  as
select * from pjinvhdr where
project_billwith like @parm1 AND
draft_num Like @parm2
order by draft_num Desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvhdr_sspv] TO [MSDSL]
    AS [dbo];

