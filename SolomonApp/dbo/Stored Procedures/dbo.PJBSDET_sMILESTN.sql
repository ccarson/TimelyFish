﻿ create procedure PJBSDET_sMILESTN  @parm1 varchar (16) ,  @parm2 varchar (6) , @parm3 smalldatetime  as
select * from PJBSDET
where    PJBSDET.Project = @parm1
and PJBSDET.Schednbr= @parm2
and PJBSDET.Rel_Status <> 'Y'
and PJBSDET.Post_Date <> ''
and PJBSDET.Amount <> 0
and PJBSDET.Post_Date_Est <= @parm3

