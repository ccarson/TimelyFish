 

Create	View vr_SalesOrder_LastShipDate
As
	Select	SOShipHeader.CpnyID, PerPost = Max(SOShipHeader.PerPost), SOShipHeader.OrdNbr, 
		ShipDateAct = Max(SOShipHeader.ShipDateAct), 
		SOShipLine.InvtID, SOShipSched.OrdSchedRef, SOShipSched.OrdLineRef
		From	SOShipHeader (NoLock) Inner Join SOShipLine (NoLock)
			On SOShipHeader.CpnyID = SOShipLine.CpnyID
			And SOShipHeader.ShipperID = SOShipLine.ShipperID
			And SOShipHeader.OrdNbr = SOShipLine.OrdNbr
			Inner Join Inventory (NoLock)
			On SOShipLine.InvtID = Inventory.InvtID
			Inner Join SOType (NoLock)
			On SOShipHeader.CpnyID = SOType.CpnyID
			And SOShipHeader.SOTypeID = SOType.SOTypeID
			Inner Join SOShipSched (NoLock)
			On SOShipHeader.CpnyID = SOShipSched.CpnyID
			And SOShipHeader.ShipperID = SOShipSched.ShipperID
			And SOShipLine.LineRef = SOShipSched.ShipperLineRef
			And SOShipHeader.OrdNbr = SOShipSched.OrdNbr
			And SOShipLine.OrdLineRef = SOShipSched.OrdLineRef
		Where	Len(RTrim(SOShipHeader.OrdNbr)) > 0	/* Only Sales Orders */
			And Inventory.StkItem = 1		/* Only Stock Items */
			And SOType.Behavior In ('SO', 'TR', 'WC', 'WO')
		Group By SOShipHeader.CpnyID, SOShipHeader.OrdNbr, SOShipLine.InvtID, SOShipSched.OrdSchedRef, 
			SOShipSched.OrdLineRef

 
