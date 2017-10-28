CREATE TABLE [dbo].[cftPGInvTran] (
    [acct]             CHAR (16)     NOT NULL,
    [BatNbr]           CHAR (10)     NOT NULL,
    [CF01]             CHAR (30)     NOT NULL,
    [CF02]             CHAR (30)     NOT NULL,
    [CF03]             CHAR (10)     NOT NULL,
    [CF04]             CHAR (10)     NOT NULL,
    [CF05]             SMALLDATETIME NOT NULL,
    [CF06]             SMALLDATETIME NOT NULL,
    [CF07]             INT           NOT NULL,
    [CF08]             INT           NOT NULL,
    [CF09]             SMALLINT      NOT NULL,
    [CF10]             SMALLINT      NOT NULL,
    [CF11]             FLOAT (53)    NOT NULL,
    [CF12]             FLOAT (53)    NOT NULL,
    [Crtd_DateTime]    SMALLDATETIME NOT NULL,
    [Crtd_Prog]        CHAR (8)      NOT NULL,
    [Crtd_User]        CHAR (10)     NOT NULL,
    [IndWgt]           FLOAT (53)    NOT NULL,
    [InvEffect]        SMALLINT      NOT NULL,
    [LineNbr]          SMALLINT      NOT NULL,
    [LUpd_DateTime]    SMALLDATETIME NOT NULL,
    [LUpd_Prog]        CHAR (8)      NOT NULL,
    [LUpd_User]        CHAR (10)     NOT NULL,
    [Module]           CHAR (2)      NOT NULL,
    [NoteID]           INT           NOT NULL,
    [PC_Stat]          SMALLINT      NOT NULL,
    [PerPost]          CHAR (6)      NOT NULL,
    [PigGroupID]       CHAR (10)     NOT NULL,
    [ProjChgBatch]     CHAR (10)     NOT NULL,
    [ProjChgLine]      SMALLINT      NOT NULL,
    [Qty]              INT           NOT NULL,
    [Reversal]         SMALLINT      NOT NULL,
    [Rlsed]            SMALLINT      NOT NULL,
    [SourceBatNbr]     CHAR (10)     NOT NULL,
    [SourceLineNbr]    SMALLINT      NOT NULL,
    [SourcePigGroupID] CHAR (10)     NOT NULL,
    [SourceProg]       CHAR (8)      NOT NULL,
    [SourceProject]    CHAR (16)     NOT NULL,
    [SourceRefNbr]     CHAR (10)     NOT NULL,
    [TotalWgt]         FLOAT (53)    NOT NULL,
    [TranDate]         SMALLDATETIME NOT NULL,
    [TranSubTypeID]    CHAR (2)      NOT NULL,
    [TranTypeID]       CHAR (2)      NOT NULL,
    [tstamp]           ROWVERSION    NULL,
    CONSTRAINT [cftPGInvTran0] PRIMARY KEY CLUSTERED ([Module] ASC, [BatNbr] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idx_cftPGInvTran_sourcepiggroupid]
    ON [dbo].[cftPGInvTran]([SourcePigGroupID] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idx_cftPGInvTran_sourceproject]
    ON [dbo].[cftPGInvTran]([SourceProject] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idx_cftPGInvTran_trantypeid]
    ON [dbo].[cftPGInvTran]([TranTypeID] ASC, [Reversal] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [cftPGInvTran_piggroupacct]
    ON [dbo].[cftPGInvTran]([PigGroupID] ASC, [acct] ASC, [Reversal] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idx_cftPGInvTran_PigGroupID_Reversal_TranTypeID]
    ON [dbo].[cftPGInvTran]([PigGroupID] ASC, [Reversal] ASC, [TranTypeID] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idx_cftPGInvTran_tranDate]
    ON [dbo].[cftPGInvTran]([TranDate] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idx_cftpginvtran_acct_rev_incl]
    ON [dbo].[cftPGInvTran]([acct] ASC, [Reversal] ASC)
    INCLUDE([InvEffect], [PigGroupID], [Qty], [TotalWgt], [TranDate]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idx_cftpginvtran_acct_rev_incl_2]
    ON [dbo].[cftPGInvTran]([acct] ASC, [Reversal] ASC)
    INCLUDE([Qty], [TranSubTypeID], [TranTypeID], [TotalWgt], [TranDate], [PigGroupID], [SourceRefNbr], [InvEffect]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idx_cftPGInvTran_acct_source]
    ON [dbo].[cftPGInvTran]([acct] ASC, [SourcePigGroupID] ASC, [SourceProject] ASC, [Reversal] ASC)
    INCLUDE([PigGroupID]) WITH (FILLFACTOR = 100);

