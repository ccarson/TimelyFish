CREATE TABLE [dbo].[cftPGInvAdj] (
    [BatNbr]        CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [LineNbr]       SMALLINT      NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (10)     NOT NULL,
    [NoteID]        SMALLINT      NOT NULL,
    [PigGroupID]    CHAR (10)     NOT NULL,
    [Qty]           INT           NOT NULL,
    [TotalWgt]      FLOAT (53)    NOT NULL,
    [TranTypeID]    CHAR (2)      NOT NULL,
    [TranSubTypeID] CHAR (2)      NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [cftPGInvAdj0] PRIMARY KEY CLUSTERED ([BatNbr] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90)
);

