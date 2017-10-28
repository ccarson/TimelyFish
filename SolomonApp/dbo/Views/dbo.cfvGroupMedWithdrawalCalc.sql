
CREATE  VIEW cfvGroupMedWithdrawalCalc
AS
SELECT v.*, SaleType = Min(mst.Description), SaleLeadTime = datediff(day,FirstPossibleSaleDate,FirstSchedDate),
	FirstActualRecordedSale = Min(ps.SaleDate), ActSaleType = Min(pst.Descr), ActSalePigQty = Min(ps.TotPigCnt)
	FROM cfvGroupMedicationWithdrawal v 					
	LEFT JOIN cftPM pm ON v.PigGroupID = pm.SourcePigGroupID AND v.FirstSchedDate = pm.MovementDate AND pm.PMID = (Select Min(PMID) From cftPM WHERE SourcePigGroupID = v.PigGroupID AND MovementDate = v.FirstSchedDate)
	LEFT JOIN cftMarketSaleType mst ON pm.MarketSaleTypeID = mst.MarketSaleTypeID
	LEFT JOIN cftPigSale ps ON v.PigGroupID = ps.PigGroupID 
					AND DocType = 'SR' 
					AND RefNbr Not In (Select OrigRefNbr FROM cftPigSale WHERE PigGroupID = v.PigGroupID AND DocType = 'RE')
					AND RefNbr = (Select Min(RefNbr) FROM cftPigSale WHERE PigGroupID = v.PigGroupID AND SaleDate = (Select Min(SaleDate) FROM cftPigSale WHERE PigGroupID = v.PigGroupID))
	LEFT JOIN cftPSType pst ON ps.SaleTypeID = pst.SalesTypeID
	GROUP BY v.Site, v.SvcMgr, v.PigProdPhaseID, v.PigGroupID, v.MktgSvcMgr, v.BarnNbr, v.Last53MedDel, v.FirstPossibleSaleDate, v.FirstSchedDate

