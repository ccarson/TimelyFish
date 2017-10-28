 CREATE  PROCEDURE ARBatch_FillWrk_DateEnt
        @CpnyID         VARCHAR(10),
        @Acct           VARCHAR(10),
        @Sub            VARCHAR(24),
        @StartDate      SMALLDATETIME,
        @EndDate        SMALLDATETIME,
        @RI_ID          SMALLINT

AS

INSERT WrkCADetail (bankacct,banksub,BatNbr,ClearAmt,ClearDate,Cleared,cpnyid,CuryID,CuryTranamt,DrCr,EntryID,Module,PayeeID,
       PC_Status,Perent,PerPost,ProjectID,RcnclStatus,Rcptdisbflg,Refnbr,RI_ID,TaskID,Tranamt,Trandate,Trandesc)

SELECT BankAcct = @Acct,
       BankSub = @Sub,
       b.BatNbr,
       Max(b.clearamt),
       Max(b.DateClr),
       Max(b.Cleared),
       CpnyID = @CpnyID,
       Max(b.CuryId),
       CuryTranAmt = Max(b.CuryDepositAmt),
       DrCr='',
       EntryID=CASE WHEN MAX(n.DocType)<>MIN(n.DocType) THEN 'PA' ELSE MAX(n.DocType) END,
       Module='AR',
       PayeeID=CASE WHEN MAX(n.CustID)<>MIN(n.CustID) THEN '' ELSE MAX(n.CustID) END,
       PC_Status='',
       Max(b.PerEnt),
       Max(b.PerPost),
       ProjectID=CASE WHEN MAX(n.ProjectID)<>MIN(n.ProjectID) THEN '' ELSE MAX(n.ProjectID) END,
       RcnclStatus='',
       Rcptdisbflg='R',
       RefNbr = CASE WHEN MAX(n.RefNbr)<>MIN(n.RefNbr) THEN '' ELSE MAX(n.RefNbr) END,
       RI_ID=@RI_ID,
       TaskID= CASE WHEN MAX(n.TaskID)<>MIN(n.TaskID) THEN '' ELSE MAX(n.TaskID) END,
       TranAmt= Max(b.DepositAmt),
       TranDate=b.DateEnt,
       TranDesc=CASE MAX(n.DocType) WHEN 'NS' THEN 'NSF Reversal' ELSE 'Deposit' END

FROM    Batch b INNER JOIN ARDoc n ON n.BatNbr=b.BatNbr

WHERE   b.CpnyID = @CpnyID AND
        b.BankAcct=@Acct AND
        b.BankSub=@Sub AND
        n.DocType IN ('PA', 'PP', 'CS', 'NS') AND
        b.dateent BETWEEN @StartDate AND @EndDate AND
        b.rlsed = 1 AND
        b.module = 'AR' AND
        b.Status <> 'V' AND
        b.battype not in ('C','R')

GROUP BY b.BatNbr, b.DateEnt

ORDER BY b.batnbr, b.dateent



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARBatch_FillWrk_DateEnt] TO [MSDSL]
    AS [dbo];

