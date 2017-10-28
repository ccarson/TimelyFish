 create procedure PJPTDSUM_severy
as
        select * from PJPTDSUM
        order by project, pjt_entity, acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDSUM_severy] TO [MSDSL]
    AS [dbo];

