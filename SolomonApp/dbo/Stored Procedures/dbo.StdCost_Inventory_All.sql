 Create Proc StdCost_Inventory_All
     @parm1 varchar ( 30)
as
Select * from Inventory
     Where InvtId like @parm1
     and valmthd = 'T'
Order by InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[StdCost_Inventory_All] TO [MSDSL]
    AS [dbo];

