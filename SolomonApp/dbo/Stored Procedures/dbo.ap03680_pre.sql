 CREATE PROC ap03680_pre @RI_ID smallint
AS
        DECLARE @ReportDate     smalldatetime

        ---  Get the report date from RptRunTime

        SELECT  @ReportDate = '12/31/2020'
        SELECT  @ReportDate = ReportDate
        FROM    RptRunTime
        WHERE   RI_ID = @RI_ID

        ---  Clean up old records if any

        DELETE FROM ap03680_wrk
        WHERE   RI_ID = @RI_ID

        ---  Update the where clause with the ri_id

        EXEC    SetRIWhere_sp   @ri_id, 'ap03680_wrk'

        ---  Insert document records into the report work table

        INSERT  ap03680_wrk (RI_ID, CpnyID, DiscDate, DocDate, DocType, DueDate, InvcDate,
							InvcNbr, OrigDocAmt, PayDate, RefNbr, Rlsed, Status, VendID,
							DocBal, CuryDocBal, CuryID, APAdjust_AdjAmt, APAdjust_AdjDiscAmt,
							APAdjust_AdjgAcct, APAdjust_AdjgDocType, APAdjust_AdjgRefNbr,
							APAdjust_AdjgSub, Vendor_Name, Vendor_Status, Vendor_CuryID, APDocCk_DocDate)
        SELECT  DISTINCT
                @RI_ID,
                APDoc.CpnyID,
                APDoc.DiscDate,
                APDoc.DocDate,
                APDoc.DocType,
                APDoc.DueDate,
                APDoc.InvcDate,
                APDoc.InvcNbr,
                APDoc.OrigDocAmt,
                APDoc.PayDate,
                APDoc.RefNbr,
                APDoc.Rlsed,
                APDoc.Status,
                APDoc.VendId,
                APDoc.DocBal,
                APDoc.CuryDocBal,
                APDoc.CuryID,

                APAdjust.AdjAmt,
                APAdjust.AdjDiscAmt,
                APAdjust.AdjgAcct,
                APAdjust.AdjgDocType,
                APAdjust.AdjgRefNbr,
                APAdjust.AdjgSub,
                Vendor.Name,
                Vendor.Status,
                Vendor.CuryID,
                NULL

        FROM    APDoc
				left outer join Vendor
					on APDoc.VendId = Vendor.VendId
				left outer join APAdjust
					on APDoc.RefNbr = APAdjust.AdjdRefNbr
						and APDoc.VendId = APAdjust.VendId
						and APDoc.DocType = APAdjust.AdjdDocType
        WHERE   APDoc.Rlsed = 1
        AND     APDoc.InvcDate <= @ReportDate

        ---  Clear unwanted document types

        DELETE FROM ap03680_wrk
        WHERE   Status = 'T'

        DELETE FROM ap03680_wrk
        WHERE   DocBal = 0.00

        ---  Update payment and adjustment information for documents
        ---  with associated adjustments

        UPDATE  ap03680_wrk
        SET     APDocCk_DocDate = APDocCk.DocDate
        FROM    ap03680_wrk, APDoc APDocCk
        WHERE   RI_ID = @RI_ID
        AND     APAdjust_AdjgAcct = APDocCk.Acct
        AND     APAdjust_AdjgSub = APDocCk.Sub
        AND     APAdjust_AdjgRefNbr = APDocCk.RefNbr
        AND     APAdjust_AdjgDocType = APDocCk.DocType


