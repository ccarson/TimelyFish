 

Create view vp_SOSchedPO as

	Select	SOSched.*
	From	SOSched

	join	SOHeader (nolock)
	on		SOHeader.CpnyID = SOSched.CpnyID 
	and		SOHeader.OrdNbr = SOSched.OrdNbr

	join	SOType (nolock)
	on		SOType.CpnyID = SOHeader.CpnyID
	and		SOType.SOTypeID = SOHeader.SOTypeID

	Where	(SOType.Behavior = 'MO' or SOSched.LotSerialReq = 0) and SOSched.LotSerialEntered = 0
	And 	QtyOrd >= 0


 
