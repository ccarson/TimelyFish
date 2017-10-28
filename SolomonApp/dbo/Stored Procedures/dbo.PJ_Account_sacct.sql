 create procedure PJ_Account_sacct @parm1 varchar (16)   as
select account.acct, account.descr, substring(account.accttype, 2,1) from  PJ_Account, Account
where pj_account.acct  =  @parm1
          and account.acct = pj_account.gl_acct
          and pj_account.acct <> ' '
order by pj_account.gl_acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJ_Account_sacct] TO [MSDSL]
    AS [dbo];

