 CREATE Proc EDItemXRef_LookUpPack @AltIdType varchar(1), @AlternateId varchar(30), @Pack int As
Select A.InvtId From ItemXRef A Inner Join Inventory B On A.InvtId = B.InvtId Inner Join
InventoryADG C On A.InvtId = C.InvtId Where A.AltIdType = @AltIdType And
A.AlternateId = @AlternateId And B.TranStatusCode = 'AC' And (C.Pack * C.PackSize) = @Pack


