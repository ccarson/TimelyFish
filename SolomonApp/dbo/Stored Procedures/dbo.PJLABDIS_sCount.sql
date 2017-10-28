 create procedure  PJLABDIS_sCount  @parm1 varchar (6)   as
select count(E1.employee)
from (Select employee
        from pjlabdis
        where fiscalno = @parm1
  union
        Select employee
        from pjexphdr
        where fiscalno = @parm1 and status_1 = 'P') as E1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABDIS_sCount] TO [MSDSL]
    AS [dbo];

