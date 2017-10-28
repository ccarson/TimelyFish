 create procedure  inventory_spk9 @parm1 varchar (250) , @parm2 varchar (30)  as
select * from  inventory
where invtid = @parm2
order by invtid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[inventory_spk9] TO [MSDSL]
    AS [dbo];

