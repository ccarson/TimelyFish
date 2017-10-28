 /****** Object:  Stored Procedure dbo.ap03615_pre    Script Date: 4/7/98 12:54:32 PM ******/
--apptable
CREATE PROC ap03615_pre @RI_ID smallint
AS

        ---  Clean up old records if any

        DELETE FROM ap03615_wrk
        WHERE   RI_ID = @RI_ID

        EXEC pb_03615 @RI_ID

        ---  Update the where clause with the ri_id

        EXEC    SetRIWhere_sp   @ri_id, 'APDoc1'


        ---  Insert check records into the work table
        ---  which are currently selected

        INSERT  ap03615_wrk (RI_ID, BatNbr, CpnyID, CuryDiscBal, CuryDiscTkn, CuryDocBal,
							DiscDate, DocType, DueDate, InvcDate, InvcNbr, PayDate, RefNbr,
							Status, Vendor_Name, Vendor_Status, Vendor_VendId, APTran_CpnyID,
							APTran_CuryTranAmt, APTran_CuryUnitPrice, APTran_DrCr, APTran_ExtRefNbr,
							APTran_RefNbr, APTran_TranType, APTran_VendId)
        SELECT  DISTINCT
                @RI_ID,
                NULL,
                APDoc.CpnyID,
                APDoc.CuryDiscBal,
                APDoc.CuryDiscTkn,
                APDoc.CuryDocBal,
                APDoc.DiscDate,
                APDoc.DocType,
                APDoc.DueDate,

                APDoc.InvcDate,
                APDoc.InvcNbr,
                APDoc.PayDate,
                APDoc.RefNbr,
                APDoc.Status,

                Vendor.Name,
                Vendor.Status,
                Vendor.VendId,

                APTran.CpnyID,
                APTran.CuryTranAmt,
                APTran.CuryUnitPrice,
                APTran.DrCr,
                APTran.ExtRefNbr,
                APTran.RefNbr,
                APTran.TranType,
                APTran.VendId

        FROM    APTran,
                APDoc,
                Vendor
        WHERE   APTran.UnitDesc = APDoc.RefNbr
        AND     Vendor.VendId = APDoc.VendId
        AND     APTran.DrCr = 'S'
        AND     rtrim(APTran.CostType) = APDoc.DocType


        ---  Update batch numbers

        UPDATE  ap03615_wrk
        SET     ap03615_wrk.BatNbr = APDoc1.BatNbr
        FROM    ap03615_wrk, APDoc APDoc1
        WHERE   RI_ID = @RI_ID
        AND     APTran_ExtRefNbr = APDoc1.InvcNbr


