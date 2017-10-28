 create procedure  subacct_spk9 @parm1 varchar (250) , @parm2 varchar (24)  as
select * from  subacct
where sub = @parm2
order by sub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[subacct_spk9] TO [MSDSL]
    AS [dbo];

