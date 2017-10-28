
--*************************************************************
--	Purpose:Update the Market Value for Tailender Transfers
--	Author: Sue Matter
--	Date: 12/26/2005
--	Usage: PigTransportRecord 
--	Parms: 
--	      
--*************************************************************

CREATE Procedure pCF522UpdateMarket 
AS 
Update cftPigMktValue 
Set MktAct= tm.WCB_AVG_PM 
From cftPigMktValue tb
JOIN cfttempMarket tm ON tb.MktDate=tm.MDate
WHERE tm.WCB_AVG_PM>0 AND ISNULL(tm.WCB_AVG_PM,'')<>'' AND tb.MktAct=0 
 


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pCF522UpdateMarket] TO [SE\ssis_datawriter]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF522UpdateMarket] TO [MSDSL]
    AS [dbo];

