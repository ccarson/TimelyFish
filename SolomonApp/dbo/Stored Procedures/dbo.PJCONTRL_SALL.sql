﻿ create procedure PJCONTRL_SALL  @parm1 varchar (2) , @parm2 varchar (30)   as
select * from PJCONTRL
where    control_type      LIKE @parm1
and    control_code      LIKE @parm2
order by control_type ,
control_code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCONTRL_SALL] TO [MSDSL]
    AS [dbo];

