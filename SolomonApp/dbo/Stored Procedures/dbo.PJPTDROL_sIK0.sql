 create procedure  PJPTDROL_sIK0
as
select * from PJPTDROL
where project = 'Z'
and acct = 'Z'


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDROL_sIK0] TO [MSDSL]
    AS [dbo];

