 create procedure PJPTDSUM_sbubrm @parm1 varchar (16) , @parm2 varchar (32)     as
select * from PJPTDSUM P, PJACCT A
where p.project =  @parm1 and
p.pjt_entity = @parm2 and
a.acct = p.acct and
a.ID1_SW = 'Y'
order by p.project, p.pjt_entity, p.acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDSUM_sbubrm] TO [MSDSL]
    AS [dbo];

