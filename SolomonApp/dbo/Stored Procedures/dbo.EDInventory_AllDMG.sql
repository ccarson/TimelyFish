 CREATE Proc EDInventory_AllDMG @parm1 varchar ( 30) as
    Select * from Inventory where InvtId like @parm1 order by InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInventory_AllDMG] TO [MSDSL]
    AS [dbo];

