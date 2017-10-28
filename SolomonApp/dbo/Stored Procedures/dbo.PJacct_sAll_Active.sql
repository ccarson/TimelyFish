create procedure [dbo].[PJacct_sAll_Active] @parm1 varchar (16)  as
select * from PJACCT
where acct like @parm1
and PJACCT.Acct_Status = 'A'
order by acct

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJacct_sAll_Active] TO [MSDSL]
    AS [dbo];

