CREATE TABLE [dbo].[cftPigProdEff] (
    [ADG]            FLOAT (53)    NOT NULL,
    [CF01]           CHAR (30)     NOT NULL,
    [CF02]           CHAR (10)     NOT NULL,
    [CF03]           SMALLDATETIME NOT NULL,
    [CF04]           SMALLINT      NOT NULL,
    [CF05]           FLOAT (53)    NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME NOT NULL,
    [Crtd_Prog]      CHAR (8)      NOT NULL,
    [Crtd_User]      CHAR (10)     NOT NULL,
    [FeedEfficiency] FLOAT (53)    NOT NULL,
    [GenderTypeID]   CHAR (1)      NOT NULL,
    [LUpd_DateTime]  SMALLDATETIME NOT NULL,
    [LUpd_Prog]      CHAR (8)      NOT NULL,
    [LUpd_User]      CHAR (10)     NOT NULL,
    [NoteID]         INT           NOT NULL,
    [PodID]          CHAR (3)      NOT NULL,
    [tstamp]         ROWVERSION    NULL,
    CONSTRAINT [cftPigProdEff0] PRIMARY KEY CLUSTERED ([GenderTypeID] ASC, [PodID] ASC) WITH (FILLFACTOR = 90)
);

