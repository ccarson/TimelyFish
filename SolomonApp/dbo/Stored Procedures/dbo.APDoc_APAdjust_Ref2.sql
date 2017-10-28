 Create Procedure APDoc_APAdjust_Ref2 @parm1 varchar ( 15) As
Select
VO.Acct, VO.BatNbr, VO.BatSeq, VO.ClearAmt, VO.ClearDate,
VO.CurrentNbr, VO.CuryDiscBal, VO.CuryDiscTkn, VO.CuryDocBal,
VO.CuryEffDate, VO.CuryId, VO.CuryMultDiv, VO.CuryOrigDocAmt,
VO.CuryPmtAmt, VO.CuryRate, VO.CuryRateType, VO.CuryTaxTot00,
VO.CuryTaxTot01, VO.CuryTaxTot02, VO.CuryTaxTot03, VO.CuryTxblTot00,
VO.CuryTxblTot01, VO.CuryTxblTot02, VO.CuryTxblTot03, VO.Cycle,
VO.DirectDeposit, VO.DiscBal, VO.DiscDate, VO.DiscTkn, VO.Doc1099,
VO.DocBal, VO.DocClass, VO.DocDate, VO.DocDesc, VO.DocType,
VO.DueDate, VO.InvcDate, VO.InvcNbr, VO.LineCntr, VO.NbrCycle,
VO.NoteID, VO.OpenDoc, VO.OrigDocAmt, VO.PayDate, VO.PerClosed,
VO.PerEnt, VO.PerPost, VO.PmtAmt, VO.PONbr, VO.RecordID,
VO.RefNbr, VO.RGOLAmt, VO.Rlsed, VO.Selected, VO.Status, VO.Sub,
VO.TaxCntr00, VO.TaxCntr01, VO.TaxCntr02, VO.TaxCntr03,
VO.TaxId00, VO.TaxId01, VO.TaxId02, VO.TaxId03,
VO.TaxTot00, VO.TaxTot01, VO.TaxTot02, VO.TaxTot03, VO.Terms,
VO.TxblTot00, VO.TxblTot01, VO.TxblTot02, VO.TxblTot03,
VO.User1, VO.User2, VO.User3, VO.User4, VO.User5, VO.User6,
VO.User7, VO.User8, VO.VendID, APAdjust.AdjAmt, APAdjust.AdjBatNbr,
APAdjust.AdjdDocType, APAdjust.AdjDiscAmt, APAdjust.AdjdRefNbr, APAdjust.AdjgAcct,
APAdjust.AdjgDocDate, APAdjust.AdjgDocType, APAdjust.AdjgPerPost,
APAdjust.AdjgRefNbr, APAdjust.AdjgSub, APAdjust.CuryAdjdAmt,
APAdjust.CuryAdjdCuryId, APAdjust.CuryAdjdDiscAmt, APAdjust.CuryAdjdMultDiv,
APAdjust.CuryAdjdRate, APAdjust.CuryAdjgAmt, APAdjust.CuryAdjgDiscAmt,
APAdjust.CuryRGOLAmt, APAdjust.DateAppl, APAdjust.PerAppl, APAdjust.User1 AdjUser1,
APAdjust.User2 AdjUser2, APAdjust.User3 AdjUser3, APAdjust.User4 AdjUser4,
APAdjust.VendId AdjVendID
into #tempapdoc
from APDoc VO
	left outer join APAdjust
		on VO.RefNbr = APAdjust.AdjdRefNbr
		and VO.DocType = APAdjust.AdjdDocType
Where
VO.VendId = @parm1 and
VO.DocClass = 'N' and
VO.Rlsed = 1 and
VO.OpenDoc = 1
Order by VO.Vendid, VO.DocClass, VO.Rlsed, VO.BatNbr, VO.RefNbr

Select APDocTmp.*, CK.*
from
#tempapdoc APDocTmp
	left outer join APDoc CK
		on APDocTmp.AdjgAcct = CK.Acct
		and APDocTmp.AdjgSub = CK.Sub
		and APDocTmp.AdjgDocType = CK.DocType
		and APDocTmp.AdjgRefNbr = CK.RefNbr
Order by APDocTmp.Vendid, APDocTmp.DocClass, APDocTmp.Rlsed, APDocTmp.BatNbr, APDocTmp.RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_APAdjust_Ref2] TO [MSDSL]
    AS [dbo];

