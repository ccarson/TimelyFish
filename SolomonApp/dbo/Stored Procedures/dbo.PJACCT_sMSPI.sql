 create procedure PJACCT_sMSPI @parm1 varchar (1)  as
select * from PJACCT
where ca_id20 like @parm1
order by acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJACCT_sMSPI] TO [MSDSL]
    AS [dbo];

