 /****** Object:  Stored Procedure dbo.APDocCK_Avail_03050    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APDocCK_Avail_03050 @parm1 varchar ( 10), @parm2 varchar(1) as
Select APCheck.*, Vendor.MultiChk, Vendor.Name, Vendor.PmtMethod, Vendor.Status, APCheckDet.*,
VO.ApplyRefNbr, VO.BatNbr, VO.CuryDiscBal, VO.CuryDiscTkn, VO.CuryDocBal, VO.CuryId, VO.CuryMultDiv, VO.CuryPmtAmt, VO.CuryRate, VO.CuryRateType,
VO.DiscBal, VO.DiscDate, VO.DiscTkn, VO.DocBal, VO.DocDate,
VO.DocType, VO.DueDate, VO.InvcDate, VO.InvcNbr, VO.OrigDocAmt, VO.PayDate,
VO.PmtAmt, VO.PmtMethod, VO.PONbr, VO.RefNbr, VO.Selected, VO.Status, VO.VendID, VO.CpnyID, VO.S4Future11, VO.MasterDocNbr from
 APCheck, Vendor, APCheckDet, APDoc VO
Where
APCheck.VendID = Vendor.VendID
and APCheck.CheckRefNbr = APCheckDet.CheckRefNbr
and APCheck.BatNbr = APCheckDet.BatNbr
and APCheckDet.RefNbr = VO.RefNbr
and Rtrim(APCheckDet.DocType) = VO.DocType
and APCheck.BatNbr = @parm1
---and APCheck.PmtMethod Like @parm2
Order by APCheck.Vendid, VO.CpnyID, CASE VO.DocType WHEN 'AC' THEN 1 WHEN 'VO' THEN 2 WHEN 'AD' THEN 3 ELSE 4 END, APCheck.CheckRefNbr, APCheckDet.RefNbr


