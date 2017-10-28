 Create Procedure pjinvtxt_sproj @parm1 varchar (16) , @parm2 varchar (1)  as
select * from  pjinvtxt where
draft_num = ' ' and
text_type = @parm2 and
project = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvtxt_sproj] TO [MSDSL]
    AS [dbo];

