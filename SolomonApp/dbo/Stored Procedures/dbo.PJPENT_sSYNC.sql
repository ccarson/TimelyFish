 create procedure PJPENT_sSYNC @parm1 varchar (16) as
select *
from PJPENT
where
MSPInterface = 'Y' and
project = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENT_sSYNC] TO [MSDSL]
    AS [dbo];

