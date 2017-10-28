--*************************************************************
--	Purpose:Updates the MarketMovement table in PigData
--		to reflect the avg weight calc for Hormel
--	Author: Charity Anderson
--	Date: 11/1/2004
--	Usage: Pig Sales Entry		 
--	Parms: BatNbr
--*************************************************************

CREATE PROC dbo.pCF518PSUPdTran
	(@parm1 as varchar(10))
AS

UPDATE cftPM
    SET ActualWgt = cast(s.AvgWgt as smallint)
    FROM cftPM mm
	JOIN (SELECT     BatNbr, PMLoadId, cast(ceiling(sum(DelvLiveWgt)/sum(HCTot)) as smallint) AS AvgWgt
FROM         dbo.cftPigSale
WHERE     (CustId = 'HOR') and BatNbr like @parm1
GROUP BY BatNbr, PMLoadId) s
ON mm.PMID
	=s.PMLoadID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF518PSUPdTran] TO [MSDSL]
    AS [dbo];

