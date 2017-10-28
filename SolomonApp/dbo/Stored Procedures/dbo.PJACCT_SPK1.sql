 create procedure PJACCT_SPK1 @parm1 varchar (16)  as
select * from PJACCT
where acct like @parm1 and
(ACCT_STATUS = 'A' or
ACCT_STATUS = 'I') AND
	ID1_SW = 'Y'
order by acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJACCT_SPK1] TO [MSDSL]
    AS [dbo];

