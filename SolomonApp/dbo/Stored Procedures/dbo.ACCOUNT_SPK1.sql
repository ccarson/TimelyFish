 create procedure ACCOUNT_SPK1 @parm1 varchar (10)  as
select * from ACCOUNT
where acct = @parm1
order by acct


