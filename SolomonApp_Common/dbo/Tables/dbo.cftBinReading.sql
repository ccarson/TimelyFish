CREATE TABLE [dbo].[cftBinReading] (
    [BinNbr]         CHAR (6)      NOT NULL,
    [BinReadingDate] SMALLDATETIME NOT NULL,
    [Crtd_Date]      SMALLDATETIME NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME NOT NULL,
    [Crtd_Prog]      CHAR (8)      NOT NULL,
    [Crtd_User]      CHAR (10)     NOT NULL,
    [Lupd_DateTime]  SMALLDATETIME NOT NULL,
    [Lupd_Prog]      CHAR (8)      NOT NULL,
    [Lupd_User]      CHAR (10)     NOT NULL,
    [NoteID]         INT           NOT NULL,
    [SiteContactID]  CHAR (6)      NOT NULL,
    [Tons]           FLOAT (53)    NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [cftBinReading0] PRIMARY KEY CLUSTERED ([SiteContactID] ASC, [BinNbr] ASC, [BinReadingDate] ASC) WITH (FILLFACTOR = 90)
);

