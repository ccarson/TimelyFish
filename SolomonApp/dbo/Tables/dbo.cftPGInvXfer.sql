CREATE TABLE [dbo].[cftPGInvXfer] (
    [acct]           CHAR (16)     NOT NULL,
    [BatNbr]         CHAR (10)     NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME NOT NULL,
    [Crtd_Prog]      CHAR (8)      NOT NULL,
    [Crtd_User]      CHAR (10)     NOT NULL,
    [DestPigGroupID] CHAR (10)     NOT NULL,
    [IndWgt]         FLOAT (53)    NOT NULL,
    [InvEffect]      SMALLINT      NOT NULL,
    [LineNbr]        SMALLINT      NOT NULL,
    [LUpd_DateTime]  SMALLDATETIME NOT NULL,
    [LUpd_Prog]      CHAR (8)      NOT NULL,
    [LUpd_User]      CHAR (10)     NOT NULL,
    [NoteID]         INT           NOT NULL,
    [Qty]            INT           NOT NULL,
    [Reversal]       SMALLINT      NULL,
    [Rlsed]          SMALLINT      NOT NULL,
    [SrcPigGroupID]  CHAR (10)     NOT NULL,
    [TotalWgt]       FLOAT (53)    NOT NULL,
    [TranDate]       SMALLDATETIME NOT NULL,
    [TranSubTypeID]  CHAR (2)      NOT NULL,
    [TranTypeID]     CHAR (2)      NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [PK_cftPGInvXfer] PRIMARY KEY NONCLUSTERED ([BatNbr] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE CLUSTERED INDEX [cftPGInvXfer0]
    ON [dbo].[cftPGInvXfer]([BatNbr] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90);

