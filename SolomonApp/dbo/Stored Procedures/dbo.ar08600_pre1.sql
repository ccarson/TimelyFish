 /****** Object:  Stored Procedure dbo.ar08600_pre1    Script Date: 4/7/98 12:54:32 PM ******/
CREATE PROC ar08600_pre1
AS

        UPDATE  ar08600_wrk
        SET     arDoc1_DocDate = ARDoc1.DocDate,
                arDoc1_DocType = ARDoc1.DocType,
                arDoc1_RefNbr = ARDoc1.RefNbr,
                ardoc1_StmtDate = ARDoc1.StmtDate
        FROM    ar08600_wrk, ardoc ARDoc1
        WHERE ARAdjust_CustId = ARDoc1.CustId
        AND     ARAdjust_AdjGDocType = ARDoc1.DocType
        AND     ARADjust_AdjGRefNbr = ARDoc1.RefNbr

        UPDATE  ar08600_wrk
        SET     arStmt_AgeDays00 = arStmt.AgeDays00,
                arStmt_AgeDays01 = arStmt.AgeDays01,
                arStmt_AgeDays02 = arStmt.AgeDays02,
                arStmt_AgeMsg00 = arStmt.AgeMsg00,
                arStmt_AgeMsg01 = arStmt.AgeMsg01,
                arStmt_AgeMsg02 = arStmt.AgeMsg02,
                arStmt_AgeMsg03 = arStmt.AgeMsg03,
                arStmt_LastStmtDate  = arStmt.LastStmtDate
        FROM    ar08600_wrk, ARStmt
        WHERE Customer_StmtCycleId = ARStmt.StmtCycleId

        UPDATE  ar08600_wrk
        SET     CountryB_Descr = CountryB.Descr
        FROM    ar08600_wrk, Country CountryB
        WHERE   Customer_BillCountry = CountryB.CountryId


