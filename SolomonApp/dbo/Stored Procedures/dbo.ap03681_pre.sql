 CREATE PROC ap03681_pre @RI_ID smallint
            AS
        DECLARE         @EndPerNbr char(6),
                        @ReportDate     smalldatetime

        ---  Get the report date from RptRunTime

        SELECT  @ReportDate = ReportDate,
                  @EndPerNbr = EndPerNbr
        FROM    RptRunTime
        WHERE   RI_ID = @RI_ID

        ---  Clean up old records if any

        DELETE FROM ap03681_wrk
        WHERE   RI_ID = @RI_ID

        ---  Update the where clause with the ri_id

        EXEC    SetRIWhere_sp   @ri_id, 'ap03681_wrk'

                ---
        ---  Select matching APDoc records into
        ---  a temp table
        ---
        CREATE TABLE    #docs
        (
                DocType         char(2),
                RefNbr          char(10),
                Status          char(1)
        )

                INSERT  #docs
                SELECT  DocType,
                        RefNbr,
                        Status
                FROM    APDoc
                WHERE   APDoc.Rlsed = 1
                --- CR# 090854 Removed statement to included all documents within a period regardless of the invoice date.
                --- AND     APDoc.InvcDate <= @ReportDate
                AND     PerPost <= @EndPerNbr
                AND     DocClass = 'N'

                ---
                ---  Include documents where payments were
                ---  posted before the document was posted
                ---  and set them to a special status
                ---
                INSERT  #docs
                SELECT  APDoc.DocType,
                        APDoc.RefNbr,
                        'Z'
                FROM    APDoc, APAdjust
                WHERE   APDoc.VendId = APAdjust.VendId
                AND     APDoc.RefNbr = APAdjust.AdjdRefNbr
                AND     APDoc.VendId = APAdjust.VendId
                AND     APDoc.DocType = APAdjust.AdjdDocType
                AND     AdjGPerPost <= @EndPerNbr
                AND     PerPost > @EndPerNbr

        ---  Insert document records into the report work table

        INSERT  ap03681_wrk (RI_ID, CpnyID, DiscDate, DocDate, DocType,
						DueDate, InvcDate, InvcNbr, OrigDocAmt, PayDate, PerPost,
						RefNbr, Rlsed, Status, VendId, DocBal, CuryDocBal,
						CuryId, APAdjust_AdjAmt, APAdjust_AdjDiscAmt,
						APAdjust_AdjgAcct, APAdjust_AdjgDocType,
						APAdjust_AdjgPerPost, APAdjust_AdjgRefNbr, APAdjust_AdjgSub,
						APAdjust_PerAppl, Vendor_Name, Vendor_Status, Vendor_CuryId,
						APDocCk_DocDate)

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
                APDoc.PerPost,
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
                APAdjust.AdjgPerPost,
                APAdjust.AdjgRefNbr,
                APAdjust.AdjgSub,
                APAdjust.PerAppl,
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
				, #docs
        WHERE APDoc.DocType = #docs.DocType
        AND     APDoc.RefNbr = #docs.RefNbr

        ---  Clear unwanted document types

        DELETE FROM ap03681_wrk
        WHERE   Status = 'T'

        --- CR# 090766 Removed statement to allow documents with a zero dollar balance to be reported on the History report.
        --- DELETE FROM ap03681_wrk
        --- WHERE   DocBal = 0.00


