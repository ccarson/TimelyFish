 create procedure PJACCT_spk4 @parm1 varchar (16)  as
select * from PJACCT
where acct like @parm1 and
id1_sw = 'Y'
order by sort_num, acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJACCT_spk4] TO [MSDSL]
    AS [dbo];

