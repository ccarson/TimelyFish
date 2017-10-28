 CREATE PROC ap03622_pre @RI_ID smallint, @BatNbr varchar(10)
AS

        ---  Clean up old records if any

        DELETE FROM ap03625_wrk
        WHERE   RI_ID = @RI_ID

        EXEC pb_03622 @RI_ID
		
        ---  Update the where clause with the ri_id

        EXEC    SetRIWhere_sp   @ri_id, 'ap03625_wrk'

        ---  Insert check records into the work table

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
                APDocCk.CpnyID,
                'C',
                APDocCk.CheckLines,
                APDocCk.DateEnt,
                APDocCk.CheckType,
                APDocCk.CuryCheckAmt,
                APDocCk.CheckNbr,
                APDocCk.Sub,
                APDocCk.VendId,
                APDocCk.CuryID,
                APDocCk.CuryCheckAmt,
                Vendor.Name,
                NULL,
                NULL,
                APAdjust.CuryPmtAmt,
                APAdjust.DocType,
                APAdjust.CuryDiscAmt,
                APAdjust.RefNbr,
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
                NULL,
                NULL,
                APAdjust.BWAmt,
                APAdjust.CuryBWAmt

        FROM    APCheck APDocCk
                left outer join Vendor Vendor
					on  APDocCk.VendId = Vendor.VendId,
                APCheckDet APAdjust
        WHERE   APDocCk.BatNbr = @BatNbr
        AND     APDocCk.CheckLines > APDocCK.CheckOffSet
        AND     APDocCk.CheckRefNbr = APAdjust.CheckRefNbr
        AND     APDocCk.BatNbr = APAdjust.BatNbr

        ---  Update document information for adjustment
        ---  records with associated documents
		
        UPDATE  ap03625_wrk
        SET     APDocVO_DiscBal = APDocVO.CuryDiscBal,
                APDocVO_DiscDate = APDocVO.DiscDate,
                APDocVO_DueDate = APDocVO.DueDate,
                APDocVO_InvcDate = APDocVO.InvcDate,
                APDocVO_InvcNbr = APDocVO.InvcNbr,
                APDocVO_OrigDocAmt = APDocVO.CuryOrigDocAmt,
                APDocVO_PayDate = APDocVO.PayDate,
                APDocVO_RefNbr = APDocVO.RefNbr,
                APDocVO_Status = APDocVO.Status,
                APDocVo_DocType = APDocVO.DocType,
                APDocVO_CuryDiscBal = APDocVO.CuryDiscBal,
                APDVO_CuryOrigDocAmt = APDocVO.CuryOrigDocAmt,
                APDocVO_CpnyID = APDocVO.CpnyID,
		Batch_Status = CONVERT(CHAR(1), Currncy.DecPl)

        FROM    ap03625_wrk, APDoc APDocVO, Currncy (NOLOCK)
        WHERE   RI_ID = @RI_ID
        AND     APAdjust_AdjdRefNbr = APDocVO.RefNbr
        AND     APAdjust_AdjdDocType = APDocVO.DocType
        AND     Currncy.CuryID = APDocVO.CuryID


