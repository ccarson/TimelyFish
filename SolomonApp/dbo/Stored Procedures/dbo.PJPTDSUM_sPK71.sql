 create procedure PJPTDSUM_sPK71 @parm1 varchar (16)   as
SELECT *
FROM  pjptdsum P, pjacct A
WHERE
p.acct = a.acct and
a.acct_type = 'EX' and
p.project = @parm1
Order by
p.project,
p.pjt_entity,
p.acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDSUM_sPK71] TO [MSDSL]
    AS [dbo];

