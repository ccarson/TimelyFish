 create procedure ACCOUNT_SALL @parm1 varchar (10)  as
select * from ACCOUNT
where acct LIKE @parm1
order by acct


