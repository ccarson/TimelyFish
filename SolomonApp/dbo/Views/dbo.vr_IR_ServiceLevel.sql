 



Create	View vr_IR_ServiceLevel
As
	Select	SOSched.CpnyID, SOOrder.PerPost, SOOrder.InvtID, SOSched.SiteID, 
		Hit = Sum(1),
		Complete = Sum(	Case	When	SOSched.QtyOrd = SOSched.QtyShip
						Then	Case	When	DateAdd(dd, -SOSched.TransitTime, SOSched.PromDate) >= SOOrder.ShipDateAct
									Then	1
								Else	0
							End
					Else	0
				End)
		From	SOSched (NoLock) Inner Join vr_SalesOrder_LastShipDate SOOrder (NoLock) 
			On SOOrder.CpnyID = SOSched.CpnyID
			And SOOrder.OrdNbr = SOSched.OrdNbr
			And SOOrder.OrdLineRef = SOSched.LineRef
			And SOOrder.OrdSchedRef = SOSched.SchedRef
		Where	SOSched.Status = 'C'		/* Only Closed Schedules */
			And SOSched.DropShip = 0		/* No Drop Ships */
			And SOSched.PromDate <> ''
		Group By SOSched.CpnyID, SOOrder.PerPost, SOOrder.InvtID, SOSched.SiteID

 
