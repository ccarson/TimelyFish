 create procedure  PJLABDIS_sExist  @parm1 varchar (6),  @parm2 varchar (10)  as
select count(E1.employee)
from (Select employee
        from pjlabdis
        where fiscalno = @parm1
  union
        Select employee
        from pjexphdr
        where fiscalno = @parm1  and status_1 = 'P') as E1
where employee = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABDIS_sExist] TO [MSDSL]
    AS [dbo];

