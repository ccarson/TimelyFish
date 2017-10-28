CREATE TABLE [dbo].[cftPGInvTranAlloc] (
    [acct]             CHAR (16)     NOT NULL,
    [BatNbr]           CHAR (10)     NOT NULL,
    [Crtd_DateTime]    SMALLDATETIME NOT NULL,
    [Crtd_Prog]        CHAR (8)      NOT NULL,
    [Crtd_User]        CHAR (10)     NOT NULL,
    [DestMovementDate] SMALLDATETIME NOT NULL,
    [DestPigGroupID]   CHAR (10)     NOT NULL,
    [LineNbr]          SMALLINT      NOT NULL,
    [LUpd_DateTime]    SMALLDATETIME NOT NULL,
    [LUpd_Prog]        CHAR (8)      NOT NULL,
    [LUpd_User]        CHAR (10)     NOT NULL,
    [Module]           CHAR (2)      NOT NULL,
    [MoveOutBatNbr]    CHAR (10)     NOT NULL,
    [MoveOutLineNbr]   SMALLINT      NOT NULL,
    [MoveOutModule]    CHAR (2)      NOT NULL,
    [RecordID]         INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SrcPigGroupID]    CHAR (10)     NOT NULL,
    [Qty]              INT           NOT NULL,
    [TranDate]         SMALLDATETIME NOT NULL,
    [TranSubTypeID]    CHAR (2)      NOT NULL,
    [TranTypeID]       CHAR (2)      NOT NULL,
    [tstamp]           ROWVERSION    NULL,
    CONSTRAINT [PK_cftPGInvTranAlloc] PRIMARY KEY NONCLUSTERED ([RecordID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE CLUSTERED INDEX [cftPGInvTranAlloc0]
    ON [dbo].[cftPGInvTranAlloc]([RecordID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPGInvTran_DestPigGroupID]
    ON [dbo].[cftPGInvTranAlloc]([DestPigGroupID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idx_cftPGInvTranAlloc_SL_cols]
    ON [dbo].[cftPGInvTranAlloc]([BatNbr] ASC, [LineNbr] ASC, [Module] ASC)
    INCLUDE([Qty], [SrcPigGroupID]) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idx_cftPGInvTranAlloc_SL2_cols]
    ON [dbo].[cftPGInvTranAlloc]([Module] ASC, [BatNbr] ASC, [LineNbr] ASC)
    INCLUDE([Qty], [SrcPigGroupID]) WITH (FILLFACTOR = 90);

