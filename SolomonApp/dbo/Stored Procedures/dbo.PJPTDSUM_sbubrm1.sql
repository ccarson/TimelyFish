 create procedure PJPTDSUM_sbubrm1 @parm1 varchar (16)   as
select * from PJPTDSUM P, PJACCT A
where p.project =  @parm1 and
a.acct = p.acct and
a.ID1_SW = 'Y'
order by p.project, p.pjt_entity, p.acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDSUM_sbubrm1] TO [MSDSL]
    AS [dbo];

