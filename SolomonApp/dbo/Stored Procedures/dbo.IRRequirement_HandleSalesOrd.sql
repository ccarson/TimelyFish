 CREATE Procedure IRRequirement_HandleSalesOrd @InvtId VarChar(30) AS
Set NoCount On
Declare @InvQtyPrecision as integer
Select @InvQtyPrecision = 9
 Select @InvQtyPrecision = DecPlQty from InSetup
-- if IsNull(@InvQtyPrecision,-1) = -1
--	Select @InvQtyPrecision = 0
-- Initial load.  Mark all items as needing review, and do for EVERY item (At this point)
Insert into IRRequirement
	Select
			'01/01/1900' 'Crtd_Datetime',
			'IRLLCCA' 'Crtd_Prog',
			'IRLLCCA' 'Crtd_User',
		SoSched.OrdNbr 'DocumentId',
		SoSched.LineRef 'DocOtherRef1',
		SoSched.SchedRef 'DocOtherRef2',
		'SO' 'DocumentType',
		SoSched.PromDate 'DueDate',
		SoSched.PromDate 'DueDatePlan',
		SoLine.InvtID 'InvtId',
			'01/01/1900' 'Lupd_Datetime',
			'IRLLCCA' 'Lupd_Prog',
			'IRLLCCA' 'Lupd_User',
		0 'QtyBalance',
		Case SOLine.UnitMultDiv 	When 'M' Then  Round((SoSched.QtyOrd - SoSched.QtyShip) * SoLine.CnvFact, @InvQtyPrecision)
					When 'D' Then  Round((SoSched.QtyOrd - SoSched.QtyShip) / SoLine.CnvFact, @InvQtyPrecision)
		End 'QtyNeeded',
		Case SOLine.UnitMultDiv 	When 'M' Then  Round((SoSched.QtyOrd - SoSched.QtyShip) * SoLine.CnvFact, @InvQtyPrecision)
					When 'D' Then  Round((SoSched.QtyOrd - SoSched.QtyShip) / SoLine.CnvFact, @InvQtyPrecision)
		End 'QtyRevised',
		0 'Revised',
			' ' 'S4Future01',
			' ' 'S4Future02',
			0.0 'S4Future03',
			0.0 'S4Future04',
			0.0 'S4Future05',
			0.0 'S4Future06',
			'01/01/1900' 'S4Future07',
			'01/01/1900' 'S4Future08',
			0 'S4Future09',
			0 'S4Future10',
			' ' 'S4Future11',
			' ' 'S4Future12',
		SoSched.SiteId 'SiteID',
			' ' 'User1',
			'01/01/1900' 'User10',
			' ' 'User2',
			' ' 'User3',
			' ' 'User4',
			0.0 'User5',
			0.0 'User6',
			' ' 'User7',
			' ' 'User8',
			'01/01/1900' 'User9',
			Null 'tstamp'
			From SOSched,SoLine,SoHeader where SoSched.Lineref = SoLine.Lineref and SoSched.OrdNbr = SoLine.OrdNbr and SoLine.InvtId = @InvtID and SoLine.OrdNbr = SoHeader.OrdNbr and SoHeader.Status = 'O' and SoHeader.Cancelled = 0 and (SoSched.QtyOrd - SoSched.QtyShip) <> 0.0

Set NoCount Off


