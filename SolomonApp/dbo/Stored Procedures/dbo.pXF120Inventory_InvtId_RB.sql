----------------------------------------------------------------------------------------
--	Purpose: PV to select/validate the inventory item
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: @RationProdClass (from cftFOSetup.ClassRation), 
--		@BagProdClass (from cftFOSetup.ClassBag), @InvtID (entered/chosed)
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120Inventory_InvtId_RB 
	@RationProdClass varchar (6), 
	@BagProdClass varchar (6), 
	@InvtID varchar (30) 
	AS 
    	SELECT * 
	FROM Inventory 
	WHERE (ClassId = @RationProdClass OR ClassId = @BagProdClass) 
	AND InvtId LIKE @InvtID
	ORDER BY InvtId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120Inventory_InvtId_RB] TO [MSDSL]
    AS [dbo];

