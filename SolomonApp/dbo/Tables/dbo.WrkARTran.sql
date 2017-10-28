CREATE TABLE [dbo].[WrkARTran] (
    [Acct]           CHAR (10)     NULL,
    [AcctDist]       SMALLINT      NULL,
    [BatNbr]         CHAR (10)     NOT NULL,
    [CmmnPct]        FLOAT (53)    NULL,
    [CnvFact]        FLOAT (53)    NULL,
    [CostType]       CHAR (8)      NULL,
    [CpnyID]         CHAR (10)     NULL,
    [CuryExtCost]    FLOAT (53)    NULL,
    [CuryID]         CHAR (4)      NULL,
    [CuryMultDiv]    CHAR (1)      NULL,
    [CuryRate]       FLOAT (53)    NULL,
    [CuryTaxAmt00]   FLOAT (53)    NULL,
    [CuryTaxAmt01]   FLOAT (53)    NULL,
    [CuryTaxAmt02]   FLOAT (53)    NULL,
    [CuryTaxAmt03]   FLOAT (53)    NULL,
    [CuryTranAmt]    FLOAT (53)    NULL,
    [CuryTxblAmt00]  FLOAT (53)    NULL,
    [CuryTxblAmt01]  FLOAT (53)    NULL,
    [CuryTxblAmt02]  FLOAT (53)    NULL,
    [CuryTxblAmt03]  FLOAT (53)    NULL,
    [CuryUnitPrice]  FLOAT (53)    NULL,
    [CustID]         CHAR (15)     NULL,
    [DrCr]           CHAR (1)      NULL,
    [Excpt]          SMALLINT      NULL,
    [ExtCost]        FLOAT (53)    NULL,
    [ExtRefNbr]      CHAR (15)     NULL,
    [FiscYr]         CHAR (4)      NULL,
    [InvtID]         CHAR (30)     NULL,
    [JobRate]        FLOAT (53)    NULL,
    [JrnlType]       CHAR (3)      NULL,
    [LineID]         INT           NULL,
    [LineNbr]        SMALLINT      NULL,
    [LineRef]        CHAR (5)      NULL,
    [NoteID]         INT           NULL,
    [PC_Flag]        CHAR (1)      NULL,
    [PC_ID]          CHAR (20)     NULL,
    [PC_Status]      CHAR (1)      NULL,
    [PerEnt]         CHAR (6)      NULL,
    [PerPost]        CHAR (6)      NULL,
    [ProjectID]      CHAR (16)     NULL,
    [Qty]            FLOAT (53)    NULL,
    [RecordID]       INT           NULL,
    [RefNbr]         CHAR (10)     NULL,
    [RI_ID]          SMALLINT      NULL,
    [Rlsed]          SMALLINT      NULL,
    [SiteID]         CHAR (10)     NULL,
    [SlsperID]       CHAR (10)     NULL,
    [SpecificCostID] CHAR (25)     NULL,
    [Sub]            CHAR (24)     NULL,
    [TaskID]         CHAR (32)     NULL,
    [TaxAmt00]       FLOAT (53)    NULL,
    [TaxAmt01]       FLOAT (53)    NULL,
    [TaxAmt02]       FLOAT (53)    NULL,
    [TaxAmt03]       FLOAT (53)    NULL,
    [TaxCalced]      CHAR (1)      NULL,
    [TaxCat]         CHAR (10)     NULL,
    [TaxID00]        CHAR (10)     NULL,
    [TaxID01]        CHAR (10)     NULL,
    [TaxID02]        CHAR (10)     NULL,
    [TaxID03]        CHAR (10)     NULL,
    [TaxIDDflt]      CHAR (10)     NULL,
    [TranAmt]        FLOAT (53)    NULL,
    [TranClass]      CHAR (1)      NULL,
    [TranDate]       SMALLDATETIME NULL,
    [TranDesc]       CHAR (30)     NULL,
    [TranType]       CHAR (2)      NULL,
    [TxblAmt00]      FLOAT (53)    NULL,
    [TxblAmt01]      FLOAT (53)    NULL,
    [TxblAmt02]      FLOAT (53)    NULL,
    [TxblAmt03]      FLOAT (53)    NULL,
    [UnitDesc]       CHAR (6)      NULL,
    [UnitPrice]      FLOAT (53)    NULL,
    [User1]          CHAR (30)     NULL,
    [User2]          CHAR (30)     NULL,
    [User3]          FLOAT (53)    NULL,
    [User4]          FLOAT (53)    NULL,
    [WhseLoc]        CHAR (10)     NULL,
    [tstamp]         ROWVERSION    NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [WrkARTran0]
    ON [dbo].[WrkARTran]([RI_ID] ASC, [BatNbr] ASC, [CustID] ASC, [TranType] ASC, [RefNbr] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [WrkARTran1]
    ON [dbo].[WrkARTran]([RecordID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [WrkARTran2]
    ON [dbo].[WrkARTran]([BatNbr] ASC, [CustID] ASC, [TranType] ASC, [RefNbr] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90);

