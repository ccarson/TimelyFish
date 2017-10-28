 create proc DMG_Inventory_CPSOn
AS
	select	CPSOnOff
	from	INSetUp (NoLock)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Inventory_CPSOn] TO [MSDSL]
    AS [dbo];

