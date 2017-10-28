Create View cfvBrent_Query1_SalesTypeQty
AS
--/*Brent_Query1_SalesTypeQty */
SELECT cftPM.PMLoadID, cftPM.PMID, cfvPIGSALEREV.BatNbr,cfvPIGSALEREV.RefNbr,
cfvPIGSALEREV.SaleDate,cfvPIGSALEREV.SiteContactID,cfvPIGSALEREV.PkrContactId,
cfvPIGSALEREV.TaskId,cfvPIGSALEREV.SaleTypeId,cftPM.PigTypeID,cftPM.MarketSaleTypeID,
cftPM.MovementDate,cftPM.DestContactID,cftPM.TruckerContactID,cftPM.EstimatedQty,
cftPSDetail.DetailTypeId,cftPSDetail.Qty,cftPSDetail.WgtLive
FROM (cftPM 
LEFT JOIN cfvPIGSALEREV ON cftPM.PMID = cfvPIGSALEREV.PMLoadId)
LEFT JOIN cftPSDetail ON (cfvPIGSALEREV.RefNbr = cftPSDetail.RefNbr) AND (cfvPIGSALEREV.ARBatNbr = cftPSDetail.BatNbr)
WHERE (((cfvPIGSALEREV.RefNbr)<>'') AND ((cfvPIGSALEREV.SaleTypeId)<>'CS'
And (cfvPIGSALEREV.SaleTypeId)<>'MC' And (cfvPIGSALEREV.SaleTypeId)<>'CB')
AND ((cftPM.PigTypeID)='04'))
--ORDER BY cftPM.PMLoadID, cftPSDetail.Qty DESC;

