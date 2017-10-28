 create procedure PJPTDSUM_sexponly @parm1 varchar (16) , @parm2 varchar (32)   as
select * from PJPTDSUM, PJACCT
where PJPTDSUM.project =  @parm1 and
PJPTDSUM.pjt_entity like @parm2 and
PJPTDSUM.acct = PJACCT.acct and
PJACCT.acct_type = 'EX'
order by PJPTDSUM.pjt_entity, PJACCT.sort_num, PJACCT.acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDSUM_sexponly] TO [MSDSL]
    AS [dbo];

