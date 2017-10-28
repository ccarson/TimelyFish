 create procedure ACCOUNT_sactive @parm1 varchar (10)  as
Select * from Account
where Acct like @parm1 and Active <> 0
Order by Acct


