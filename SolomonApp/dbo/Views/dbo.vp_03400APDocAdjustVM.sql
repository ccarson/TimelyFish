 

CREATE VIEW vp_03400APDocAdjustVM AS

/****** File Name: 0317vp_03400APDocAdjustVM					******/
/****** Created by DCR 12/01/98 13:30 			******/
/****** Select/Calculate amounts to be affecting adjusted & adjusting 	******/
/****** document balances & other fields.						******/


/***** Update VM Master Doc *****/
SELECT j.VendID, w.UserAddress, j.adjbatnbr, j.AdjdDocType, CuryDiscAmt = SUM(j.CuryAdjdDiscAmt), 
	CuryAdjAmt = SUM(j.CuryAdjdAmt), AdjDiscAmt = SUM(j.AdjDiscAmt), 
	AdjAmt = SUM(j.AdjAmt),
        CASE WHEN j.adjgperpost > d.perpost THEN j.adjgperpost 
             else d.perpost
        END perpost, 
        DrCr = ' ', d.MasterDocNbr
FROM   WrkRelease w WITH(NOLOCK), APDoc d, APAdjust j 
WHERE j.AdjdRefNbr = d.RefNbr AND j.AdjdDocType = d.DocType AND w.BatNbr = j.AdjBatNbr
	AND w.Module = 'AP' AND j.VendID = d.VendID AND d.s4future11 = 'VM' 
GROUP BY j.VendID, w.UserAddress, j.adjbatnbr, d.masterdocnbr, j.AdjdDocType, j.adjgperpost ,d.perpost



 
