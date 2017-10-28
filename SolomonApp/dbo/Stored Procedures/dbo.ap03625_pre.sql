 CREATE PROC ap03625_pre @RI_ID smallint,  @lines integer
AS

        ---  Clean up old records if any

        DELETE FROM ap03625_wrk
        WHERE   RI_ID = @RI_ID

        ---  Update the where clause with the ri_id

        EXEC    SetRIWhere_sp   @ri_id, 'ap03625_wrk'

        ---  Insert check records into the work table
        ---  which are in the requested
        ---  beginning and ending periods.

        INSERT  ap03625_wrk (RI_ID, Acct, BatNbr, CpnyID, DocClass, DocCnt, DocDate, DocType,
						OrigDocAmt, RefNbr, Sub, VendId, CuryID, CuryOrigDocAmt, Vendor_Name,
						Batch_Module, Batch_Status, APAdjust_AdjAmt, APAdjust_AdjdDocType,
						APAdjust_AdjDiscAmt, APAdjust_AdjdRefNbr, APAdjust_CuryAdjGAmt,
						APAdj_CuryAdjGDscAmt, APDocVO_CpnyID, APDocVO_DiscBal, APDocVO_DiscDate,
						APDocVO_DueDate, APDocVO_InvcDate, APDocVO_InvcNbr, APDocVO_OrigDocAmt,
						APDocVO_PayDate, APDocVO_RefNbr, APDocVO_Status, APDocVO_DocType,
						APDocVO_CuryDiscBal, APDVO_CuryOrigDocAmt, BWAmt, CuryAdjGBkupWthld)

SELECT  DISTINCT
                @RI_ID,
                APDocCk.Acct,
                APDocCk.BatNbr,
                APDocCK.CpnyID,
                APDocCk.DocClass,
                NULL,
                APDocCk.DocDate,
                APDocCk.DocType,
                APDocCk.OrigDocAmt,
                APDocCk.RefNbr,
                APDocCk.Sub,
                APDocCk.VendId,
                APDocCk.CuryID,
                APDocCk.CuryOrigDocAmt,
                Vendor.Name,
                Batch.Module,
                Batch.Status,
                APAdjust.AdjAmt,
                APAdjust.AdjdDocType,
                APAdjust.AdjDiscAmt,
                APAdjust.AdjdRefNbr,
                CASE APAdjust.CuryAdjdCuryID WHEN APDocCk.CuryID THEN APAdjust.CuryAdjDAmt ELSE  APAdjust.CuryAdjGAmt END,
                CASE APAdjust.CuryAdjdCuryID WHEN APDocCk.CuryID THEN APAdjust.CuryAdjDDiscAmt ELSE APAdjust.CuryAdjGDiscAmt END,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                APadjust.AdjBkupWthld,
                Apadjust.CuryAdjGBkupWthld

        FROM    APDoc APDocCk
				left outer join  Vendor Vendor
					on APDocCk.VendId = Vendor.VendId,
                Batch Batch,
                APAdjust APAdjust
        WHERE   APDocCk.BatNbr = Batch.BatNbr
        AND     APDocCk.RefNbr = APAdjust.AdjgRefNbr
        AND     APDocCk.DocType = APAdjust.AdjgDocType
        AND     APDocCk.Acct = APAdjust.AdjgAcct
        AND     APDocCk.Sub = APAdjust.AdjgSub
        AND     Batch.Module = 'AP'
        AND     Batch.Status IN ( 'S', 'U', 'P', 'B' )

        delete from ap03625_wrk where doctype <> 'CK'

        ---  Update document information for adjustment
        ---  records with associated documents

        UPDATE  ap03625_wrk
        SET     APDocVO_CpnyID = APDocVO.CpnyID,
                APDocVO_DiscBal = APDocVO.DiscBal,
                APDocVO_DiscDate = APDocVO.DiscDate,
                APDocVO_DueDate = APDocVO.DueDate,
                APDocVO_InvcDate = APDocVO.InvcDate,
                APDocVO_InvcNbr = APDocVO.InvcNbr,
                APDocVO_OrigDocAmt = APDocVO.OrigDocAmt,
                APDocVO_PayDate = APDocVO.PayDate,
                APDocVO_RefNbr = APDocVO.RefNbr,
                APDocVO_Status = APDocVO.Status,
                APDocVo_DocType = APDocVO.DocType,
                APDocVO_CuryDiscBal = APDocVO.CuryDiscBal,
                APDVO_CuryOrigDocAmt = APDocVO.CuryOrigDocAmt

        FROM    ap03625_wrk, APDoc APDocVO
        WHERE   RI_ID = @RI_ID
 AND     APAdjust_AdjdRefNbr = APDocVO.RefNbr
        AND     APAdjust_AdjdDocType = APDocVO.DocType

        ---  Change the sign of adjustment records

        UPDATE  ap03625_wrk
        SET     APAdjust_AdjAmt = -1 * APAdjust_AdjAmt,
                APAdjust_AdjDiscAmt = -1 * APAdjust_AdjDiscAmt
        WHERE   RI_ID = @RI_ID
        AND     APAdjust_AdjdDocType = 'AD'

        ---  Update the DocCnt field with the number of adjustment records

        UPDATE  ap03625_wrk
        SET     ap03625_wrk.DocCnt = (Select Count(APAdjust.AdjgRefNbr)
                        FROM APAdjust
                        WHERE APAdjust.AdjgRefNbr = ap03625_wrk.RefNbr and
                                 APAdjust.AdjgDocType = ap03625_wrk.DocType and
                                 APAdjust.AdjgAcct = ap03625_wrk.Acct and
                                 APAdjust.AdjgSub = ap03625_wrk.Sub)
        WHERE RI_ID = @RI_ID

        delete from ap03625_wrk where ap03625_wrk.DocCnt < @lines


