
--*************************************************************
--	Purpose:Pig Sale Account Detail
--		
--	Author: Charity Anderson
--	Date: 7/18/2005
--	Usage: EssBase vCFPigSaleEssbase
--	Parms: None
--*************************************************************
CREATE VIEW vCFPigSaleDetailUNION 
AS
Select RefNbr, 'AmtCheck' as Account, AmtCheck as Value
FROM cftPigSale
where PigGroupID>'' and AmtCheck<>0
UNION ALL
Select RefNbr, 'AmtBaseSale' as Account, AmtBaseSale
FROM cftPigSale
where PigGroupID>'' and AmtBaseSale<>0
UNION ALL
Select RefNbr, 'AmtGradePrem' as Account, AmtGradePrem
FROM cftPigSale
where PigGroupID>'' and AmtGradePrem<>0
UNION ALL
Select RefNbr, 'AmtInsect' as Account, AmtInsect
FROM cftPigSale
where PigGroupID>'' and AmtInsect<>0
UNION ALL
Select RefNbr, 'AmtNPPC' as Account, AmtNPPC
FROM cftPigSale
where PigGroupID>'' and AmtNPPC<>0
UNION ALL
Select RefNbr, 'AmtOther' as Account, AmtOther
FROM cftPigSale
where PigGroupID>'' and AmtOther<>0
UNION ALL
Select RefNbr, 'AmtScale' as Account, AmtScale
FROM cftPigSale
where PigGroupID>'' and AmtScale<>0
UNION ALL
Select RefNbr, 'AmtSortLoss' as Account, AmtSortLoss
FROM cftPigSale
where PigGroupID>'' and AmtSortLoss<>0
UNION ALL
Select RefNbr, 'AmtTruck' as Account, AmtTruck
FROM cftPigSale
where PigGroupID>'' and AmtTruck<>0
UNION ALL
Select RefNbr, 'DelvCarcWgt' as Account, DelvCarcWgt
FROM cftPigSale
where PigGroupID>'' 
UNION ALL
Select RefNbr, 'DelvLiveWgt' as Account, DelvLiveWgt
FROM cftPigSale
where PigGroupID>''
UNION ALL
Select RefNbr, 'AmtInsur' as Account, AmtInsur
FROM cftPigSale
where PigGroupID>'' and AmtInsur<>0

UNION ALL
Select RefNbr,
'LW_' + DetailTypeID 
Account,WgtLive as Value
FROM cftPSDetail 
where WgtLive<>0

UNION ALL
Select RefNbr,
'CW_' + DetailTypeID 
Account,WgtCarc as Value
FROM cftPSDetail 

UNION ALL
Select RefNbr,'HC_' + DetailTypeID as Account,
Qty
FROM cftPSDetail 

UNION ALL 
Select RefNbr,'EstWgt' as Account,
cast(pm.EstimatedWgt as smallint) as Value 
FROM cftPigSale ps
JOIN cftPM pm on ps.PMLoadID=pm.PMID
where pm.EstimatedWgt>0
