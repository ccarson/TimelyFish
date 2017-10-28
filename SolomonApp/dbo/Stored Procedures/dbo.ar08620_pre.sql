 CREATE PROC ar08620_pre @RI_ID smallint as
declare                 @B char(6),
                        @E char(6),
                        @N char(30)

        DELETE FROM ar08620_wrk
        WHERE RI_ID = @RI_ID

        EXEC    SetRIWhere_sp @RI_ID, 'ar08620_wrk'

        SELECT  @B = '', @E = 'zzzzzz', @N = '08620'

        SELECT  @B = BegPerNbr,
                    @E = EndPerNbr,
                @N = ReportName
        FROM    RptRunTime
        WHERE   RI_ID = @RI_ID

        CREATE TABLE            #tbl1
        (
        J_CustId                        char(10)        NULL,
        J_AdjdDocType					char(2)         NULL,
        J_AdjdRefNbr					char(10)        NULL,
        J_AdjAmt                        float           NULL,
        J_Ada							float           NULL,
        J_Cada							float           NULL,
        J_Caa							float           NULL,
        C_DocDate                       smalldatetime   NULL,
        C_DocDesc                       char(30)        NULL,
        C_DocType                       char(2)         NULL,
        C_PerClosed                     char(6)         NULL,
        C_PerEnt                        char(6)         NULL,
        C_PerPost                       char(6)         NULL,
        C_RefNbr                        char(10)                NULL
        )

        CREATE TABLE            #tbl2
        (
        A_Cdb							float           NULL,
        A_CuryId                        char(4)			NULL,
        A_Coda							float           NULL,
        A_CustId                        char(10)        NULL,
        A_DocBal                        float           NULL,
        A_DocDate                       smalldatetime   NULL,
        A_DocDesc                       char(30)        NULL,
        A_DocType                       char(2)         NULL,
        A_Oda							float           NULL,
        A_PerClosed                     char(6)         NULL,
        A_PerEnt                        char(6)         NULL,
        A_PerPost                       char(6)         NULL,
        A_RefNbr                        char(10)        NULL,
        A_Rlsed                         smallint        NULL,
        J_AdjAmt                        float           NULL,
        J_Ada							float           NULL,
        J_Cada							float           NULL,
        J_Caa							float           NULL,
        C_DocDate                       smalldatetime   NULL,
        C_DocDesc                       char(30)        NULL,
        C_DocType                       char(2)         NULL,
        C_PerClosed                     char(6)         NULL,
        C_PerEnt                        char(6)         NULL,
        C_PerPost                       char(6)         NULL,
        C_RefNbr                        char(10)        NULL
        )

        CREATE TABLE            #sumarbal
        (CustId         char(15)        NULL,
        CustCurBal      float           NULL
        )

        Insert  #sumARBal
        select
                ar_balances.Custid,
                CustCurBal = SUM(AR_Balances.Currbal)
        FROM AR_Balances
        GROUP BY Ar_balances.Custid

        INSERT                  #tbl1
        SELECT
        J.CustId,
        J.AdjdDocType,
        J.AdjdRefNbr,
        J.AdjAmt,
        J.AdjDiscAmt,
        J.CuryAdjdDiscAmt,
        J.CuryAdjgAmt,

        D.DocDate,
        D.DocDesc,
        D.DocType,
        D.PerClosed,
        D.PerEnt,
        D.PerPost,
        D.RefNbr

        FROM ARAdjust J
			left outer join ARDoc D
			on J.CustId = D.CustId
			and J.AdjgDocType = D.DocType
			and J.AdjgRefNbr = D.RefNbr

        INSERT                  #tbl2
        SELECT

        D.CuryDocBal,
        D.CuryId,
        D.CuryOrigDocAmt,
        D.CustId,
        D.DocBal,
        D.DocDate,
        D.DocDesc,
        D.DocType,
        D.OrigDocAmt,
        D.PerClosed,
        D.PerEnt,
        D.PerPost,
        D.RefNbr,
        D.Rlsed,

        J.J_AdjAmt,
        J.J_Ada,
        J.J_Cada,
        J.J_Caa,
        J.C_DocDate,
        J.C_DocDesc,
        J.C_DocType,
        J.C_PerClosed,
        J.C_PerEnt,
        J.C_PerPost,
        J.C_RefNbr

        FROM ARDoc D
			left outer join #tbl1 J
			on D.CustId = J.J_CustId
			and D.DocType = J.J_AdjdDocType
			and D.RefNbr= J.J_AdjdRefNbr
		WHERE
        @E < J.C_PerPost and  D.PerPost <= @E

IF @N <> '08620' AND @N <> '08620MC'
 ---add future checks back into the docbal except for 'All Documents' reports
BEGIN
   update #tbl2 set A_DocBal = A_DocBal +
   (select sum(J.J_AdjAmt) + sum(J.J_Ada)
FROM #tbl1 J
	left outer join #tbl2 A
		on A.A_CustId = J.J_CustId
        and A.A_DocType = J.J_AdjdDocType
        and A.A_RefNbr = J.J_AdjdRefNbr
WHERE  @E < J.C_PerPost and  A_PerPost <= @E
        group by J.J_AdjdDocType,J.J_AdjdRefNbr)
END

  INSERT                        #tbl2
        SELECT

        D.CuryDocBal,
        D.CuryId,
        D.CuryOrigDocAmt,
        D.CustId,
        D.DocBal,
        D.DocDate,
        D.DocDesc,
        D.DocType,
        D.OrigDocAmt,
        D.PerClosed,
        D.PerEnt,
        D.PerPost,
        D.RefNbr,
        D.Rlsed,

        J.J_AdjAmt,
        J.J_Ada,
        J.J_Cada,
        J.J_Caa,
        J.C_DocDate,
        J.C_DocDesc,
        J.C_DocType,
        J.C_PerClosed,
        J.C_PerEnt,
        J.C_PerPost,
        J.C_RefNbr

        FROM ARDoc D
			left outer join #tbl1 J
				on D.CustId = J.J_CustId
				and D.DocType = J.J_AdjdDocType
				and D.RefNbr = J.J_AdjdRefNbr
		Where
        @E >= J.C_PerPost

        INSERT                  ar08620_wrk
        SELECT

        @RI_ID,
        C.ArAcct,
        C.ArSub,
        S.custcurbal,
        C.CustId,
        C.Name,
        C.PerNbr,
        D.A_Cdb,
        D.A_CuryId,
        D.A_Coda,
        D.A_CustId,
        D.A_DocBal,
        D.A_DocDate,
        D.A_DocDesc,
        D.A_DocType,
        D.A_Oda,
        D.A_PerClosed,
        D.A_PerEnt,
        D.A_PerPost,
        D.A_RefNbr,
        D.A_Rlsed,
        D.J_AdjAmt,
        D.J_Ada,
        D.J_Cada,
        D.J_Caa,
        D.C_DocDate,
        D.C_DocDesc,
        D.C_DocType,
        D.C_PerClosed,
        D.C_PerEnt,
        D.C_PerPost,
        D.C_RefNbr,
        NULL

        FROM Customer C
			left outer join #tbl2 D
				on C.CustId = D.A_CustId
			left outer join #SumARBal S
				on C.Custid = S.Custid

        UPDATE ar08620_wrk set ARDoc_DocType = 'ZZ' where ARDoc_PerPost > @E



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ar08620_pre] TO [MSDSL]
    AS [dbo];

