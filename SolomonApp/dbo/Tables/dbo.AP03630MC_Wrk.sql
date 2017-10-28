CREATE TABLE [dbo].[AP03630MC_Wrk] (
    [RI_ID]                SMALLINT      NOT NULL,
    [Acct]                 CHAR (10)     NULL,
    [BatNbr]               CHAR (10)     NULL,
    [CpnyID]               CHAR (10)     NULL,
    [CuryId]               CHAR (4)      NULL,
    [DocClass]             CHAR (1)      NULL,
    [DocDate]              SMALLDATETIME NULL,
    [DocType]              CHAR (2)      NULL,
    [OrigDocAmt]           FLOAT (53)    NULL,
    [CuryOrigDocAmt]       FLOAT (53)    NULL,
    [PerClosed]            CHAR (6)      NULL,
    [PerPost]              CHAR (6)      NULL,
    [RefNbr]               CHAR (10)     NULL,
    [Sub]                  CHAR (24)     NULL,
    [VendId]               CHAR (15)     NULL,
    [Vendor_Name]          CHAR (60)     NOT NULL,
    [GLSetup_BaseCuryID]   CHAR (4)      NULL,
    [APAdjust_AdjAmt]      FLOAT (53)    NULL,
    [APAdjust_AdjDiscAmt]  FLOAT (53)    NULL,
    [APAdjust_AdjgPerPost] CHAR (6)      NULL,
    [APAdjust_CuryAdjdAmt] FLOAT (53)    NULL,
    [APAdj_CuryAdjdDscAmt] FLOAT (53)    NULL,
    [APAdjust_AdjdRefNbr]  CHAR (10)     NULL,
    [APAdjust_AdjddocType] CHAR (2)      NULL,
    [APDocVO_CpnyID]       CHAR (10)     NULL,
    [APDocVO_CuryID]       CHAR (4)      NULL,
    [APDocVO_DocType]      CHAR (2)      NULL,
    [APDocVO_InvcDate]     SMALLDATETIME NULL,
    [APDocVO_InvcNbr]      CHAR (15)     NULL,
    [APDocVO_RefNbr]       CHAR (10)     NULL,
    [tstamp]               ROWVERSION    NOT NULL
);


GO
CREATE CLUSTERED INDEX [ap03630mc_wrk0]
    ON [dbo].[AP03630MC_Wrk]([RI_ID] ASC) WITH (FILLFACTOR = 90);

