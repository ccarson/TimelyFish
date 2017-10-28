CREATE TABLE [dbo].[cftPGInvTSub] (
    [Crtd_DateTime]   SMALLDATETIME NOT NULL,
    [Crtd_Program]    CHAR (8)      NOT NULL,
    [Crtd_User]       CHAR (10)     NOT NULL,
    [Description]     CHAR (30)     NOT NULL,
    [DestProdPhaseID] CHAR (3)      NULL,
    [LUpd_DateTime]   SMALLDATETIME NOT NULL,
    [LUpd_Prog]       CHAR (8)      NOT NULL,
    [LUpd_User]       CHAR (10)     NOT NULL,
    [NoteID]          INT           NOT NULL,
    [PurchCountry]    CHAR (3)      NOT NULL,
    [SrcProdPhaseID]  CHAR (3)      NULL,
    [SubTypeID]       CHAR (2)      NOT NULL,
    [TranTypeID]      CHAR (2)      NOT NULL,
    [tstamp]          ROWVERSION    NULL,
    CONSTRAINT [cftPGInvTSub0] PRIMARY KEY CLUSTERED ([TranTypeID] ASC, [SubTypeID] ASC) WITH (FILLFACTOR = 90)
);

