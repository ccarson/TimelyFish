 CREATE Proc EDInventory_StkUnitClass @InvtId varchar(30) As
Select A.StkUnit,A.ClassId,B.PackMethod,B.Pack, B.PackSize, Cast (B.PackUOM As char(6)),B.StdCartonBreak
From Inventory A, InventoryADG B Where A.InvtId = @InvtId And A.InvtId = B.InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInventory_StkUnitClass] TO [MSDSL]
    AS [dbo];

