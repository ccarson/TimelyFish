--*************************************************************
--	Purpose: Current Pig Group Sales
--	Author: Sue Matter
--	Date: 6/1/2005
--	Usage: XP601 
--	Parms: 
--	       
--*************************************************************


CREATE    View cfv_XP601TranSale
AS
Select pg.ProjectID,
       pg.TaskID,
       tr.acct,
       tr.TranDate,
       tr.BatNbr,
       tr.SourceBatNbr,
       tr.SourceLineNbr,
       Qty=(tr.Qty*tr.InvEffect),
       tr.TotalWgt,
       ps.CustId,
       cs.Name As Packer,
       ct.ContactName As Trucker
  From cftPigGroup pg
  JOIN cftPGInvTran tr ON pg.PigGroupID=tr.PigGroupID
  LEFT JOIN cftPigSale ps ON tr.SourceBatNbr=ps.BatNbr AND tr.SourceRefNbr=ps.RefNbr
  LEFT JOIN Customer cs ON ps.CustID=cs.CustId
  LEFT JOIN cftPM pm ON ps.PMLoadId=pm.PMID AND pm.PMTypeID='02'
  LEFT JOIN cftContact ct ON pm.TruckerContactID=ct.ContactID
  Where tr.Reversal<>'1' AND tr.TranTypeID='PS' 


 