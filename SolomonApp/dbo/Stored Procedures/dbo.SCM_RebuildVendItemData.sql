 Create Proc SCM_RebuildVendItemData
as

delete  from VendItem

Declare @DecPlQty as Integer
Declare @DecPlPrcCst As Integer
SELECT @DecPlQty = DecPlQty, @DecPlPrcCst = DecPlPrcCst from POSETUP

INSERT INTO VendItem
	(InvtID, SiteID, VendID, FiscYr, AlternateID,
	Crtd_DateTime, Crtd_Prog, Crtd_User,
	LUpd_DateTime, LUpd_Prog, LUpd_User,
	PTDCostRcvd00, PTDCostRcvd01, PTDCostRcvd02, PTDCostRcvd03,
	PTDCostRcvd04, PTDCostRcvd05, PTDCostRcvd06, PTDCostRcvd07,
	PTDCostRcvd08, PTDCostRcvd09, PTDCostRcvd10, PTDCostRcvd11, PTDCostRcvd12,
	PTDQtyRcvd00, PTDQtyRcvd01, PTDQtyRcvd02, PTDQtyRcvd03,
	PTDQtyRcvd04, PTDQtyRcvd05, PTDQtyRcvd06, PTDQtyRcvd07,
	PTDQtyRcvd08, PTDQtyRcvd09, PTDQtyRcvd10, PTDQtyRcvd11, PTDQtyRcvd12,
	PTDCostRet00, PTDCostRet01, PTDCostRet02, PTDCostRet03,
	PTDCostRet04, PTDCostRet05, PTDCostRet06, PTDCostRet07,
	PTDCostRet08, PTDCostRet09, PTDCostRet10, PTDCostRet11, PTDCostRet12,
	PTDQtyRet00, PTDQtyRet01, PTDQtyRet02, PTDQtyRet03,
	PTDQtyRet04, PTDQtyRet05, PTDQtyRet06, PTDQtyRet07,
	PTDQtyRet08, PTDQtyRet09, PTDQtyRet10, PTDQtyRet11, PTDQtyRet12,
	PTDRcptNbr00, PTDRcptNbr01, PTDRcptNbr02, PTDRcptNbr03,
	PTDRcptNbr04, PTDRcptNbr05, PTDRcptNbr06, PTDRcptNbr07,
	PTDRcptNbr08, PTDRcptNbr09, PTDRcptNbr10, PTDRcptNbr11, PTDRcptNbr12,
	PTDLeadTime00, PTDLeadTime01, PTDLeadTime02, PTDLeadTime03,
	PTDLeadTime04, PTDLeadTime05, PTDLeadTime06, PTDLeadTime07,
	PTDLeadTime08, PTDLeadTime09, PTDLeadTime10, PTDLeadTime11, PTDLeadTime12)

SELECT 	T.InvtID, T.SiteID, T.VendID, Left(T.PerPost, 4), T.AlternateID,
	GetDate(), 'DBUPDATE', 'DBUPDATE',
	GetDate(), 'DBUPDATE', 'DBUPDATE',
	PTDCostRcvd00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' and T.Trantype = 'R')
				Then T.ExtCost else 0 end),
	PTDCostRcvd01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' and T.Trantype = 'R')
				Then T.ExtCost else 0 end),
	PTDCostRcvd02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' and T.Trantype = 'R')
				Then T.ExtCost else 0 end),
	PTDCostRcvd03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' and T.Trantype = 'R')
				Then T.ExtCost else 0 end),
	PTDCostRcvd04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' and T.Trantype = 'R')
				Then T.ExtCost else 0 end),
	PTDCostRcvd05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' and T.Trantype = 'R')
				Then T.ExtCost else 0 end),
	PTDCostRcvd06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' and T.Trantype = 'R')
				Then T.ExtCost else 0 end),
	PTDCostRcvd07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' and T.Trantype = 'R')
				Then T.ExtCost else 0 end),
	PTDCostRcvd08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' and T.Trantype = 'R')
				Then T.ExtCost else 0 end),
	PTDCostRcvd09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' and T.Trantype = 'R')
				Then T.ExtCost else 0 end),
	PTDCostRcvd10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' and T.Trantype = 'R')
				Then T.ExtCost else 0 end),
	PTDCostRcvd11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' and T.Trantype = 'R')
				Then T.ExtCost else 0 end),
	PTDCostRcvd12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' and T.Trantype = 'R')
				Then T.ExtCost else 0 end),
		PTDQtyRcvd00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' and T.Trantype = 'R')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),
	PTDQtyRcvd01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' and T.Trantype = 'R')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),
	PTDQtyRcvd02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' and T.Trantype = 'R')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),
	PTDQtyRcvd03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' and T.Trantype = 'R')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),
	PTDQtyRcvd04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' and T.Trantype = 'R')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),
	PTDQtyRcvd05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' and T.Trantype = 'R')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),
	PTDQtyRcvd06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' and T.Trantype = 'R')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),
	PTDQtyRcvd07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' and T.Trantype = 'R')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),
	PTDQtyRcvd08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' and T.Trantype = 'R')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),
	PTDQtyRcvd09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' and T.Trantype = 'R')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),
	PTDQtyRcvd10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' and T.Trantype = 'R')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),
	PTDQtyRcvd11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' and T.Trantype = 'R')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),
	PTDQtyRcvd12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' and T.Trantype = 'R')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),
 	PTDCostRet00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' and T.Trantype = 'X')
				Then T.ExtCost else 0 end),
	PTDCostRet01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' and T.Trantype = 'X')
				Then T.ExtCost else 0 end),
	PTDCostRet02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' and T.Trantype = 'X')
				Then T.ExtCost else 0 end),
	PTDCostRet03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' and T.Trantype = 'X')
				Then T.ExtCost else 0 end),
	PTDCostRet04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' and T.Trantype = 'X')
				Then T.ExtCost else 0 end),
	PTDCostRet05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' and T.Trantype = 'X')
				Then T.ExtCost else 0 end),
	PTDCostRet06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' and T.Trantype = 'X')
				Then T.ExtCost else 0 end),
	PTDCostRet07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' and T.Trantype = 'X')
				Then T.ExtCost else 0 end),
	PTDCostRet08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' and T.Trantype = 'X')
				Then T.ExtCost else 0 end),
	PTDCostRet09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' and T.Trantype = 'X')
				Then T.ExtCost else 0 end),
	PTDCostRet10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' and T.Trantype = 'X')
				Then T.ExtCost else 0 end),
	PTDCostRet11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' and T.Trantype = 'X')
				Then T.ExtCost else 0 end),
	PTDCostRet12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' and T.Trantype = 'X')
				Then T.ExtCost else 0 end),

	PTDQtyRet00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' and T.Trantype = 'X')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),
	PTDQtyRet01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' and T.Trantype = 'X')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),
	PTDQtyRet02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' and T.Trantype = 'X')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),
	PTDQtyRet03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' and T.Trantype = 'X')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),
	PTDQtyRet04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' and T.Trantype = 'X')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),
	PTDQtyRet05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' and T.Trantype = 'X')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),
	PTDQtyRet06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' and T.Trantype = 'X')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),
	PTDQtyRet07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' and T.Trantype = 'X')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),
	PTDQtyRet08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' and T.Trantype = 'X')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),
	PTDQtyRet09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' and T.Trantype = 'X')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),
	PTDQtyRet10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' and T.Trantype = 'X')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),
	PTDQtyRet11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' and T.Trantype = 'X')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),
	PTDQtyRet12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' and T.Trantype = 'X')
				Then (CASE WHEN RTRIM(T.RcptMultDiv) = 'D' and T.RcptConvFact <> 0
					Then ROUND(T.RcptQty / T.RcptConvFact, @DecPlQty)
					Else ROUND(T.RcptQty * T.RcptConvFact, @DecPlQty) end)
				Else 0 end),

	PTDRcptNbr00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' and T.Trantype = 'R')
				Then 1 else 0 end),
	PTDRcptNbr01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' and T.Trantype = 'R')
				Then 1 else 0 end),
	PTDRcptNbr02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' and T.Trantype = 'R')
				Then 1 else 0 end),
	PTDRcptNbr03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' and T.Trantype = 'R')
				Then 1 else 0 end),
	PTDRcptNbr04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' and T.Trantype = 'R')
				Then 1 else 0 end),
	PTDRcptNbr05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' and T.Trantype = 'R')
				Then 1 else 0 end),
	PTDRcptNbr06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' and T.Trantype = 'R')
				Then 1 else 0 end),
	PTDRcptNbr07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' and T.Trantype = 'R')
				Then 1 else 0 end),
	PTDRcptNbr08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' and T.Trantype = 'R')
				Then 1 else 0 end),
	PTDRcptNbr09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' and T.Trantype = 'R')
				Then 1 else 0 end),
	PTDRcptNbr10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' and T.Trantype = 'R')
				Then 1 else 0 end),
	PTDRcptNbr11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' and T.Trantype = 'R')
				Then 1 else 0 end),
	PTDRcptNbr12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' and T.Trantype = 'R')
				Then 1 else 0 end),
	PTDLeadTime00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' and T.Trantype = 'R' and P.PODate is Not Null)
				Then DateDiff(dd, P.PODate, T.RcptDate) else 0 end),
	PTDLeadTime01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' and T.Trantype = 'R' and P.PODate is Not Null)
				Then DateDiff(dd, P.PODate, T.RcptDate) else 0 end),
	PTDLeadTime02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' and T.Trantype = 'R' and P.PODate is Not Null)
				Then DateDiff(dd, P.PODate, T.RcptDate) else 0 end),
	PTDLeadTime03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' and T.Trantype = 'R' and P.PODate is Not Null)
				Then DateDiff(dd, P.PODate, T.RcptDate) else 0 end),
	PTDLeadTime04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' and T.Trantype = 'R' and P.PODate is Not Null)
				Then DateDiff(dd, P.PODate, T.RcptDate) else 0 end),
	PTDLeadTime05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' and T.Trantype = 'R' and P.PODate is Not Null)
				Then DateDiff(dd, P.PODate, T.RcptDate) else 0 end),
	PTDLeadTime06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' and T.Trantype = 'R' and P.PODate is Not Null)
				Then DateDiff(dd, P.PODate, T.RcptDate) else 0 end),
	PTDLeadTime07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' and T.Trantype = 'R' and P.PODate is Not Null)
				Then DateDiff(dd, P.PODate, T.RcptDate) else 0 end),
	PTDLeadTime08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' and T.Trantype = 'R' and P.PODate is Not Null)
				Then DateDiff(dd, P.PODate, T.RcptDate) else 0 end),
	PTDLeadTime09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' and T.Trantype = 'R' and P.PODate is Not Null)
				Then DateDiff(dd, P.PODate, T.RcptDate) else 0 end),
	PTDLeadTime10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' and T.Trantype = 'R' and P.PODate is Not Null)
				Then DateDiff(dd, P.PODate, T.RcptDate) else 0 end),
	PTDLeadTime11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' and T.Trantype = 'R' and P.PODate is Not Null)
				Then DateDiff(dd, P.PODate, T.RcptDate) else 0 end),
	PTDLeadTime12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' and T.Trantype = 'R' and P.PODate is Not Null)
				Then DateDiff(dd, P.PODate, T.RcptDate) else 0 end)
FROM 	POTran T
Left Join PurchOrd P on P.PONbr = T.PONbr
group by T.InvtID, T.SiteID, T.VendID, Left(T.PerPost, 4), T.AlternateID

UPDATE	VendItem
SET	PTDAvgCost00 = (CASE WHEN (PTDQtyRcvd00 <> 0) Then (PTDCostRcvd00 / PTDQtyRcvd00) else 0 end),
	PTDAvgCost01 = (CASE WHEN (PTDQtyRcvd01 <> 0) Then (PTDCostRcvd01 / PTDQtyRcvd01) else 0 end),
	PTDAvgCost02 = (CASE WHEN (PTDQtyRcvd02 <> 0) Then (PTDCostRcvd02 / PTDQtyRcvd02) else 0 end),
	PTDAvgCost03 = (CASE WHEN (PTDQtyRcvd03 <> 0) Then (PTDCostRcvd03 / PTDQtyRcvd03) else 0 end),
	PTDAvgCost04 = (CASE WHEN (PTDQtyRcvd04 <> 0) Then (PTDCostRcvd04 / PTDQtyRcvd04) else 0 end),
	PTDAvgCost05 = (CASE WHEN (PTDQtyRcvd05 <> 0) Then (PTDCostRcvd05 / PTDQtyRcvd05) else 0 end),
	PTDAvgCost06 = (CASE WHEN (PTDQtyRcvd06 <> 0) Then (PTDCostRcvd06 / PTDQtyRcvd06) else 0 end),
	PTDAvgCost07 = (CASE WHEN (PTDQtyRcvd07 <> 0) Then (PTDCostRcvd07 / PTDQtyRcvd07) else 0 end),
	PTDAvgCost08 = (CASE WHEN (PTDQtyRcvd08 <> 0) Then (PTDCostRcvd08 / PTDQtyRcvd08) else 0 end),
	PTDAvgCost09 = (CASE WHEN (PTDQtyRcvd09 <> 0) Then (PTDCostRcvd09 / PTDQtyRcvd09) else 0 end),
	PTDAvgCost10 = (CASE WHEN (PTDQtyRcvd10 <> 0) Then (PTDCostRcvd10 / PTDQtyRcvd10) else 0 end),
	PTDAvgCost11 = (CASE WHEN (PTDQtyRcvd11 <> 0) Then (PTDCostRcvd11 / PTDQtyRcvd11) else 0 end),
	PTDAvgCost12 = (CASE WHEN (PTDQtyRcvd12 <> 0) Then (PTDCostRcvd12 / PTDQtyRcvd12) else 0 end)

UPDATE	VendItem
SET	YTDCostRcvd = 	(PTDCostRcvd00 + PTDCostRcvd01 + PTDCostRcvd02 + PTDCostRcvd03 + PTDCostRcvd04 +
			PTDCostRcvd05 + PTDCostRcvd06 + PTDCostRcvd07 + PTDCostRcvd08 + PTDCostRcvd09 +
			PTDCostRcvd10 + PTDCostRcvd11 + PTDCostRcvd12),
	YTDCostRet = 	(PTDCostRet00 + PTDCostRet01 + PTDCostRet02 + PTDCostRet03 + PTDCostRet04 +
			PTDCostRet05 + PTDCostRet06 + PTDCostRet07 + PTDCostRet08 + PTDCostRet09 +
			PTDCostRet10 + PTDCostRet11 + PTDCostRet12),
	YTDLeadTime =	(PTDLeadTime00 + PTDLeadTime01 + PTDLeadTime02 + PTDLeadTime03 + PTDLeadTime04 +
			PTDLeadTime05 + PTDLeadTime06 + PTDLeadTime07 + PTDLeadTime08 + PTDLeadTime09 +
			PTDLeadTime10 + PTDLeadTime11 + PTDLeadTime12),
	YTDQtyRcvd =	(PTDQtyRcvd00 + PTDQtyRcvd01 + PTDQtyRcvd02 + PTDQtyRcvd03 + PTDQtyRcvd04 +
			PTDQtyRcvd05 + PTDQtyRcvd06 + PTDQtyRcvd07 + PTDQtyRcvd08 + PTDQtyRcvd09 +
			PTDQtyRcvd10 + PTDQtyRcvd11 + PTDQtyRcvd12),
	YTDQtyRet = 	(PTDQtyRet00 + PTDQtyRet01 + PTDQtyRet02 + PTDQtyRet03 + PTDQtyRet04 +
			PTDQtyRet05 + PTDQtyRet06 + PTDQtyRet07 + PTDQtyRet08 + PTDQtyRet09 +
			PTDQtyRet10 + PTDQtyRet11 + PTDQtyRet12),
	YTDRcptNbr = 	(PTDRcptNbr00 + PTDRcptNbr01 + PTDRcptNbr02 + PTDRcptNbr03 + PTDRcptNbr04 +
			PTDRcptNbr05 + PTDRcptNbr06 + PTDRcptNbr07 + PTDRcptNbr08 + PTDRcptNbr09 +
			PTDRcptNbr10 + PTDRcptNbr11 + PTDRcptNbr12)

UPDATE	V
SET	UnitCost = ISNULL(T.UnitCost,0),
        LastCost = ISNull(Round(Case T.RcptMultDiv
                               WHEN 'M' THEN t.UnitCost * (1/t.RcptConvFact)
                               ELSE t.UnitCost * RcptConvFact
                          END,@DecPlPrcCst),0),
	LastRcvd = ISNULL(T.RcptDate,CONVERT(smalldatetime,'')),
	LeadTime = ISNULL(DateDiff(dd, P.PODate, T.RcptDate),0),
	YTDAvgCost = YTDCostRcvd / Case When YTDQtyRcvd = 0 THEN 1 ELSE YTDQtyRcvd END
FROM 	VendItem V
Left Join POTran T with (nolock) on V.InvtID = T.InvtID
  and 	V.SiteID = T.SiteID
  and	V.VendID = T.VendID
  and	V.FiscYr = Left(T.PerPost, 4)
  and	V.AlternateID = T.AlternateID
Left Join PurchOrd P on P.PONbr = T.PONbr
where 	T.TranType = 'R'
  and	T.tstamp = 	(SELECT Top 1 tstamp
			FROM POTran T2(nolock)
			WHERE T.InvtID = T2.InvtID
			  and T.SiteID = T2.SiteID
			  and T.VendID = T2.VendID
			  and Left(T.PerPost, 4) = Left(T2.PerPost, 4)
			  and T.AlternateID = T2.AlternateID
                        Order By rcptdate desc,tstamp desc)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_RebuildVendItemData] TO [MSDSL]
    AS [dbo];

