 create procedure PJACCT_spk2 @parm1 varchar (16)  as
select * from PJACCT
where acct like @parm1 and
id2_sw = '1' and
(acct_status = 'A' or
acct_status = 'I')
order by sort_num, acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJACCT_spk2] TO [MSDSL]
    AS [dbo];

