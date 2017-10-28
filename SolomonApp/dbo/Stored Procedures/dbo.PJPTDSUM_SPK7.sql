 create procedure PJPTDSUM_SPK7 @parm1 varchar (16)   as
SELECT
p.project,
p.pjt_entity,
p.acct,
p.act_amount,
p.eac_amount,
p.com_amount,
a.acct_type
FROM  pjptdsum p, pjacct a
WHERE
p.project = @parm1 and
p.acct = a.acct and
a.acct_type = 'EX'
Order by
p.project,
p.pjt_entity,
p.acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDSUM_SPK7] TO [MSDSL]
    AS [dbo];

