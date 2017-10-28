CREATE TABLE [dbo].[Wrk10400_GLTran] (
    [Acct]      CHAR (10)     CONSTRAINT [DF_Wrk10400_GLTran_Acct] DEFAULT (' ') NOT NULL,
    [BatNbr]    CHAR (10)     CONSTRAINT [DF_Wrk10400_GLTran_BatNbr] DEFAULT (' ') NOT NULL,
    [CpnyID]    CHAR (10)     CONSTRAINT [DF_Wrk10400_GLTran_CpnyID] DEFAULT (' ') NOT NULL,
    [CrAmt]     FLOAT (53)    CONSTRAINT [DF_Wrk10400_GLTran_CrAmt] DEFAULT ((0)) NOT NULL,
    [DrAmt]     FLOAT (53)    CONSTRAINT [DF_Wrk10400_GLTran_DrAmt] DEFAULT ((0)) NOT NULL,
    [DrCr]      CHAR (1)      CONSTRAINT [DF_Wrk10400_GLTran_DrCr] DEFAULT (' ') NOT NULL,
    [InvtID]    CHAR (30)     CONSTRAINT [DF_Wrk10400_GLTran_InvtID] DEFAULT (' ') NOT NULL,
    [JrnlType]  CHAR (3)      CONSTRAINT [DF_Wrk10400_GLTran_JrnlType] DEFAULT (' ') NOT NULL,
    [LineID]    INT           CONSTRAINT [DF_Wrk10400_GLTran_LineID] DEFAULT ((0)) NOT NULL,
    [LineNbr]   SMALLINT      CONSTRAINT [DF_Wrk10400_GLTran_LineNbr] DEFAULT ((0)) NOT NULL,
    [Module]    CHAR (2)      CONSTRAINT [DF_Wrk10400_GLTran_Module] DEFAULT (' ') NOT NULL,
    [ProjectID] CHAR (16)     CONSTRAINT [DF_Wrk10400_GLTran_ProjectID] DEFAULT (' ') NOT NULL,
    [Qty]       FLOAT (53)    CONSTRAINT [DF_Wrk10400_GLTran_Qty] DEFAULT ((0)) NOT NULL,
    [RecordID]  INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [RefNbr]    CHAR (15)     CONSTRAINT [DF_Wrk10400_GLTran_RefNbr] DEFAULT (' ') NOT NULL,
    [Sub]       CHAR (24)     CONSTRAINT [DF_Wrk10400_GLTran_Sub] DEFAULT (' ') NOT NULL,
    [TaskID]    CHAR (32)     CONSTRAINT [DF_Wrk10400_GLTran_TaskID] DEFAULT (' ') NOT NULL,
    [TranDate]  SMALLDATETIME CONSTRAINT [DF_Wrk10400_GLTran_TranDate] DEFAULT ('01/01/1900') NOT NULL,
    [TranDesc]  CHAR (30)     CONSTRAINT [DF_Wrk10400_GLTran_TranDesc] DEFAULT (' ') NOT NULL,
    [TranType]  CHAR (2)      CONSTRAINT [DF_Wrk10400_GLTran_TranType] DEFAULT (' ') NOT NULL,
    [tstamp]    ROWVERSION    NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [Wrk10400_GLTran0]
    ON [dbo].[Wrk10400_GLTran]([BatNbr] ASC, [Module] ASC, [RecordID] ASC);

