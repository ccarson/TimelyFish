 /********* Object:  Stored Procedure dbo.APDoc_APAdjust_Ref  Script Date:  06/07/01 4:27pm  ******/
CREATE PROCEDURE APDoc_APAdjust_Ref
@parm1 varchar ( 15), @parm2 int
-- @parm1 is vendor, @parm2 is accessnbr
AS
SELECT
        VO.*,
	j.AdjAmt,
        j.AdjdDocType, j.AdjDiscAmt, j.AdjdRefNbr, j.AdjgAcct,
        j.AdjgDocType,
        j.AdjgRefNbr, j.AdjgSub,
	j.CuryAdjdAmt,
        j.CuryAdjdDiscAmt,
	j.CuryRGOLAmt, j.AdjBkupWthld, j.CuryAdjdBkupWthld, 
      CK.Acct, CK.Batnbr, CK.ClearDate, CK.CpnyID, CK.DocDate,
      CK.DocType, CK.Estatus, CK.PerClosed, CK.PerEnt, CK.PerPost,
      CK.PmtMethod, CK.RefNbr, CK.Status, CK.Sub,
      CK.VendId

FROM WrkApDoc JOIN APDoc VO
                ON WrkApDoc.RefNbr = VO.RefNbr
               AND WrkApDoc.DocType = VO.DocType
          LEFT JOIN APAdjust j
                 ON VO.RefNbr = j.AdjdRefNbr AND
                    VO.DocType = j.AdjdDocType
          LEFT JOIN APDOC CK
                 ON j.AdjgAcct = CK.Acct AND
                    j.AdjgSub = CK.Sub AND
                    j.AdjgDocType = CK.DocType AND
                    j.AdjgRefNbr = CK.RefNbr

WHERE
        WrkApDoc.AccessNbr = @parm2 AND
        VO.VendId = @parm1 AND
        VO.DocClass = 'N' AND
        VO.Rlsed = 1 AND
        VO.DocType <> 'VT'

ORDER BY
        VO.VendId, VO.DocClass, VO.Rlsed, VO.BatNbr, VO.RefNbr


