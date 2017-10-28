create procedure PJPROJ_sSYNC @parm1 varchar (16), @parm2 varchar (16) as
select * 
from PJPROJ 
where 
MSPInterface = 'Y' and
@parm1 <= project  and
@parm2 >= project

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_sSYNC] TO [MSDSL]
    AS [dbo];

