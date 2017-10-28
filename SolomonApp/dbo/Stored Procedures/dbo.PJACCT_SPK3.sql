 create procedure PJACCT_SPK3 @parm1 varchar (16)  as
select * from PJACCT
where    acct        like @parm1
and    acct_status =    'A'
order by acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJACCT_SPK3] TO [MSDSL]
    AS [dbo];

