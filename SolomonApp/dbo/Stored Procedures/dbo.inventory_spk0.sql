 create procedure inventory_spk0 @parm1 varchar (30)  as
select * from Inventory
where InvtId = @parm1
order by InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[inventory_spk0] TO [MSDSL]
    AS [dbo];

