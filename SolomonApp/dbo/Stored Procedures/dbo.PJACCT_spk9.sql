 create procedure PJACCT_spk9 @parm1 varchar (250) , @parm2 varchar (16)  as
select * from PJACCT
where acct = @parm2
order by acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJACCT_spk9] TO [MSDSL]
    AS [dbo];

