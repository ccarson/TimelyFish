CREATE TABLE [dbo].[cftBinReadingTemp] (
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
    [tstamp]         ROWVERSION    NOT NULL
);


GO
CREATE CLUSTERED INDEX [cftBinReadingTempInd]
    ON [dbo].[cftBinReadingTemp]([BinNbr] ASC, [BinReadingDate] ASC, [SiteContactID] ASC) WITH (FILLFACTOR = 90);

