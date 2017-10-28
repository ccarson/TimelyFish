 Create Procedure APDoc_APAdjust_Ref4_CpnyID @parm1 varchar ( 15), @parm2 varchar ( 10) As
Select
VO.*, APAdjust.AdjAmt, APAdjust.AdjBatNbr, APAdjust.AdjBkupWthld,
APAdjust.AdjdDocType, APAdjust.AdjDiscAmt, APAdjust.AdjdRefNbr, APAdjust.AdjgAcct,
APAdjust.AdjgDocDate, APAdjust.AdjgDocType, APAdjust.AdjgPerPost,
APAdjust.AdjgRefNbr, APAdjust.AdjgSub,  APAdjust.Crtd_DateTime, APAdjust.Crtd_Prog,APAdjust.Crtd_User,
APAdjust.CuryAdjdAmt, APAdjust.CuryAdjdBkupWthld,
APAdjust.CuryAdjdCuryId, APAdjust.CuryAdjdDiscAmt, APAdjust.CuryAdjdMultDiv,
APAdjust.CuryAdjdRate, APAdjust.CuryAdjgAmt, APAdjust.CuryAdjgBkupWthld,  APAdjust.CuryAdjgDiscAmt,
APAdjust.CuryRGOLAmt, APAdjust.DateAppl, APAdjust.PerAppl, APAdjust.User1 AdjUser1,
APAdjust.User2 AdjUser2, APAdjust.User3 AdjUser3, APAdjust.User4 AdjUser4,
APAdjust.VendId AdjVendID

from APDoc VO
	left outer join APAdjust
		on VO.RefNbr = APAdjust.AdjdRefNbr
		and VO.DocType = APAdjust.AdjdDocType
Where
VO.VendId = @parm1 and
VO.CpnyId LIKE @parm2 and
VO.DocClass = 'N' and
VO.Rlsed = 1
And (VO.CurrentNbr = 1)
Order by VO.VendId, VO.DocClass, VO.Rlsed, VO.BatNbr, VO.RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_APAdjust_Ref4_CpnyID] TO [MSDSL]
    AS [dbo];

