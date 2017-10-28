 CREATE PROC ap03650_pre @RI_ID smallint AS
        DECLARE @BegPerNbr      char (6),
                @EndPerNbr      char (6),
                @PerNbr         char (6),
                @GLBaseCuryId   char (4),
                @ReportName     char (30)

        SELECT  @BegPerNbr = '', @EndPerNbr = 'zzzzzz', @ReportName = '03650'
        SELECT  @BegPerNbr = BegPerNbr,
                @EndPerNbr = EndPerNbr,
                @PerNbr = PerNbr,
                @ReportName = ReportName
        FROM    RptRunTime
        WHERE   RI_ID = @RI_ID

        SELECT  @GLBaseCuryID = BaseCuryID
        FROM    GLSetup

        DELETE FROM ap03650mc_wrk
        WHERE   RI_ID = @RI_ID

        EXEC    SetRIWhere_sp   @ri_id, 'ap03650mc_wrk'

        INSERT  ap03650mc_wrk (RI_ID, CpnyID, CuryDocBal, DocBal, CuryId, CuryOrigDocAmt, DocClass,
							DocDate, DocType, InvcDate, OrigDocAmt, PerClosed, PerEnt, PerPost,
							RefNbr, Rlsed, Status, VendId, InvcNbr, Vendor_Name, Vendor_APAcct,
							Vendor_APSub, GLSetup_BaseCuryID, APAdjust_AdjAmt, APAdjust_AdjdDocType,
							APAdjust_AdjDiscAmt, APAdjust_AdjdRefNbr, APAdjust_AdjgAcct,
							APAdjust_AdjgDocType, APAdjust_AdjgRefNbr, APAdjust_AdjgSub,
							APAdjust_CuryAdjgAmt, APAdjust_CuryAdjdAmt, APAdj_CuryAdjdDscAmt,
							APDoc1_CpnyID, APDoc1_DocDate, APDoc1_DocType, APDoc1_PerClosed,
							APDoc1_PerEnt, APDoc1_PerPost, APDoc1_RefNbr, APDoc1_DocClass, APDoc1_VendID)
        SELECT  DISTINCT
                @RI_ID,
                APDoc.CpnyID,
                APDoc.CuryDocBal,
                APDoc.DocBal,
                APDoc.CuryId,
                APDoc.CuryOrigDocAmt,
                APDoc.DocClass,
                APDoc.DocDate,
                APDoc.DocType,
                APDoc.InvcDate,
                APDoc.OrigDocAmt,
                APDoc.PerClosed,
                APDoc.PerEnt,
                APDoc.PerPost,
                APDoc.RefNbr,
                APDoc.Rlsed,
                APDoc.Status,
                APDoc.VendId,
                APDoc.InvcNbr,
                Vendor.Name,
                Vendor.APAcct,
                Vendor.APSub,
                @GLBaseCuryId,
                -1*APAdjust.AdjAmt,
                APAdjust.AdjdDocType,
                -1*APAdjust.AdjDiscAmt,
                APAdjust.AdjdRefNbr,
                APAdjust.AdjgAcct,
                APAdjust.AdjgDocType,
                APAdjust.AdjgRefNbr,
                APAdjust.AdjgSub,
                -1*APAdjust.CuryAdjgAmt,
                -1*APAdjust.CuryAdjdAmt,
                -1*APAdjust.CuryAdjdDiscAmt,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
				NULL

        FROM    APDoc
				left outer join Vendor
					on APDoc.VendId = Vendor.VendId
				left outer join APAdjust
					on APDoc.RefNbr = APAdjust.AdjdRefNbr
						AND APDoc.VendId = APAdjust.VendId
						AND APDoc.DocType = APAdjust.AdjdDocType
        WHERE APDoc.DocClass = 'N'

        UPDATE  ap03650mc_wrk
        SET     APDoc1_CpnyID = APDoc1.CpnyID,
                APDoc1_DocDate = APDoc1.DocDate,
                APDoc1_DocType = APDoc1.DocType,
                APDoc1_PerClosed = APDoc1.PerClosed,
                APDoc1_PerEnt = APDoc1.PerEnt,
                APDoc1_PerPost = APDoc1.PerPost,
                APDoc1_RefNbr = APDoc1.RefNbr,
                APDoc1_DocClass = APDoc1.DocClass,
                APDoc1_VendID = APDoc1.VendID
        FROM    ap03650mc_wrk, APDoc APDoc1
        WHERE   RI_ID = @RI_ID
        AND     APAdjust_AdjgAcct = APDoc1.Acct
        AND     APAdjust_AdjgSub = APDoc1.Sub
        AND     APAdjust_AdjgRefNbr = APDoc1.RefNbr
        AND     APAdjust_AdjgDocType = APDoc1.DocType

        UPDATE  ap03650mc_wrk
        SET     OrigDocAmt = -1 * OrigDocAmt,
                CuryOrigDocAmt = -1 * CuryOrigDocAmt,
                DocBal = -1 * DocBal,
                CuryDocBal = -1 * CuryDocBal
        WHERE   RI_ID = @RI_ID
        AND     DocType = 'AD'

        UPDATE  ap03650mc_wrk
        SET     APAdjust_AdjAmt = -1 * APAdjust_AdjAmt,
                APAdjust_AdjDiscAmt = -1 * APAdjust_AdjDiscAmt,
                APAdjust_CuryAdjgAmt = -1 * APAdjust_CuryAdjgAmt,
                APAdjust_CuryAdjdAmt = -1* APAdjust_CuryAdjdAmt,
                APAdj_CuryAdjdDscAmt = -1 * APAdj_CuryAdjdDscAmt
        WHERE   RI_ID = @RI_ID
        AND     APAdjust_AdjDDocType = 'AD'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ap03650_pre] TO [MSDSL]
    AS [dbo];

