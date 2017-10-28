 CREATE Procedure IRFind_TotalPO @InvtID VarChar(30), @SiteID VarChar(10) As
	Select
		Sum	(	Case UnitMultDiv 	When 'M' Then  Round((QtyOrd - QtyRcvd) * CnvFact, 9)
							When 'D' Then  Round((QtyOrd - QtyRcvd) / CnvFact, 9)
				End
			)'QtyNeeded'
	From
		PurOrdDet
	Where
		InvtId = @InvtId
		And SiteID = @SiteID
		and exists (Select * from PurchOrd where Purchord.PoNbr = PurOrdDet.PoNbr and Purchord.Status in ('O','P','Q'))



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRFind_TotalPO] TO [MSDSL]
    AS [dbo];

