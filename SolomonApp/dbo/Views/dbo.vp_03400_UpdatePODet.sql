 



CREATE VIEW dbo.vp_03400_UpdatePODet AS

Select p.ponbr,p.lineref, qty = Sum(
			CASE WHEN t.RcptMultDiv = t.UnitMultDiv AND t.RcptConvFact = t.CnvFact THEN CONVERT(DEC(25,9),v.qty) ELSE
			CASE WHEN t.RcptMultDiv = 'M' AND t.UnitMultDiv = 'M' THEN ROUND(CONVERT(DEC(25,9),v.qty) * CONVERT(DEC(25,9),t.RcptConvFact) / CONVERT(DEC(25,9),ISNULL(NULLIF(t.CnvFact,0),1)),s.DecPlQty)
			     WHEN t.RcptMultDiv = 'M' AND t.UnitMultDiv = 'D' THEN ROUND(CONVERT(DEC(25,9),v.qty) * CONVERT(DEC(25,9),t.RcptConvFact) * CONVERT(DEC(25,9),t.CnvFact),s.DecPlQty)
			     WHEN t.RcptMultDiv = 'D' AND t.UnitMultDiv = 'D' THEN ROUND(CONVERT(DEC(25,9),v.qty) / CONVERT(DEC(25,9),ISNULL(NULLIF(t.RcptConvFact,0),1)) * CONVERT(DEC(25,9),t.CnvFact),s.DecPlQty)
			     WHEN t.RcptMultDiv = 'D' AND t.UnitMultDiv = 'M' THEN ROUND(CONVERT(DEC(25,9),v.qty) / CONVERT(DEC(25,9),ISNULL(NULLIF(t.RcptConvFact,0),1)) / CONVERT(DEC(25,9),ISNULL(NULLIF(t.CnvFact,0),1)),s.DecPlQty)
			ELSE CONVERT(DEC(25,9),v.qty) END END
			* case when v.trantype = "AD" then -1 else 1 end),

       tranamt = Sum(CONVERT(DEC(28,3),v.tranamt) * case when v.trantype = "AD" then -1 else 1 end),
       curytranamt = Sum(CONVERT(DEC(28,3),v.curytranamt) * case when v.trantype = "AD" then -1 else 1 end),v.useraddress,
       VouchStage = 
	CASE when min(p.PurchaseType) = 'MI' or  min(p.PurchaseType) =  'FR' Then
		Case when (CONVERT(DEC(28,3),p.curycostvouched) + Sum(CONVERT(DEC(28,3),v.curytranamt) * case when v.trantype = "AD" then -1 else 1 end)+ sum(abs(CONVERT(DEC(28,3),v.curyppv)))) >=
                     Case When CONVERT(DEC(28,3),p.CuryExtCost) > CONVERT(DEC(28,3),p.CuryCostReceived) Then CONVERT(DEC(28,3),p.CuryExtCost) Else CONVERT(DEC(28,3),p.CuryCostReceived) End
                         Then 'F'
                         Else 'P'
		end
                when min(p.PurchaseType) = 'SE' or  min(p.PurchaseType) =  'SP' or  min(p.PurchaseType) =  'GD' 
			  	Then
		Case when CONVERT(DEC(28,3),p.curycostvouched) >= CONVERT(DEC(28,3),p.CuryExtCost) 
                         Then 'F'
                         Else 'P'
		end
	        ELSE
		Case when (CONVERT(DEC(25,9),p.QtyVouched) + Sum(
			CASE WHEN t.RcptMultDiv = t.UnitMultDiv AND t.RcptConvFact = t.CnvFact THEN CONVERT(DEC(25,9),v.qty) ELSE
			CASE WHEN t.RcptMultDiv = 'M' AND t.UnitMultDiv = 'M' THEN ROUND(CONVERT(DEC(25,9),v.qty) * CONVERT(DEC(25,9),t.RcptConvFact) / CONVERT(DEC(25,9),ISNULL(NULLIF(t.CnvFact,0),1)),s.DecPlQty)
			     WHEN t.RcptMultDiv = 'M' AND t.UnitMultDiv = 'D' THEN ROUND(CONVERT(DEC(25,9),v.qty) * CONVERT(DEC(25,9),t.RcptConvFact) * CONVERT(DEC(25,9),t.CnvFact),s.DecPlQty)
			     WHEN t.RcptMultDiv = 'D' AND t.UnitMultDiv = 'D' THEN ROUND(CONVERT(DEC(25,9),v.qty) / CONVERT(DEC(25,9),ISNULL(NULLIF(t.RcptConvFact,0),1)) * CONVERT(DEC(25,9),t.CnvFact),s.DecPlQty)
			     WHEN t.RcptMultDiv = 'D' AND t.UnitMultDiv = 'M' THEN ROUND(CONVERT(DEC(25,9),v.qty) / CONVERT(DEC(25,9),ISNULL(NULLIF(t.RcptConvFact,0),1)) / CONVERT(DEC(25,9),ISNULL(NULLIF(t.CnvFact,0),1)),s.DecPlQty)
			ELSE CONVERT(DEC(25,9),v.qty) END END
			* case when v.trantype = "AD" then -1 else 1 end)) >= CONVERT(DEC(25,9),p.qtyord)
                         Then 'F'
                         Else 'P'
                    end
	END
From Purorddet p 
join PoTran T on p.ponbr = t.ponbr and p.lineref = t.polineref
join dbo.vp_03400_PO_VOQtyCost v on v.rcptnbr = t.rcptnbr and v.rcptlineref = t.lineref
cross join posetup s
Group By p.PONBR,p.lineref,p.qtyvouched,p.qtyord,p.curycostvouched, p.curycostreceived, v.useraddress, p.CuryExtCost 







 
