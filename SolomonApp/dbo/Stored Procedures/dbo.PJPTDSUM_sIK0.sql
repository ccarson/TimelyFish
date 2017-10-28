 create procedure  PJPTDSUM_sIK0
as
select * from PJPTDSUM
where project = 'Z'
and pjt_entity = 'Z'
and acct = 'Z'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDSUM_sIK0] TO [MSDSL]
    AS [dbo];

