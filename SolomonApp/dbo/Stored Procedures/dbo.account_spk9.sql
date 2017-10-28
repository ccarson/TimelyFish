 create procedure  account_spk9 @parm1 varchar (250) , @parm2 varchar (10)  as
select * from  account
where acct = @parm2
order by acct


