 CREATE procedure IRInventoryRO_SelForMatAnal AS
if not exists (select * from sysobjects where id = object_id(N'[dbo].[IRCEPRestrict]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	Select * from Inventory order by InvtID
Else
	If (select count(*) from IRCepRestrict) > 0
		Select * from Inventory where exists (Select * from IRCepRestrict where IRCepRestrict.InvtId = Inventory.InvtId) order by InvtID
	Else
		Select * from Inventory order by InvtID

-- InventoryRO_SelForMatAnal



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRInventoryRO_SelForMatAnal] TO [MSDSL]
    AS [dbo];

