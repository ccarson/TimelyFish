CREATE TABLE [dbo].[cftBin] (
    [Active]        SMALLINT      NOT NULL,
    [BarnNbr]       CHAR (6)      NOT NULL,
    [BinNbr]        CHAR (6)      NOT NULL,
    [BinSortOrder]  SMALLINT      NOT NULL,
    [BinTypeID]     CHAR (3)      NOT NULL,
    [ContactID]     CHAR (6)      NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [FeedingLevel]  CHAR (10)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [RoomNbr]       CHAR (10)     NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [cftBin0] PRIMARY KEY CLUSTERED ([ContactID] ASC, [BinNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idx_cftBin_binnbr_incl]
    ON [dbo].[cftBin]([BinNbr] ASC)
    INCLUDE([BarnNbr], [BinTypeID], [ContactID], [RoomNbr]) WITH (FILLFACTOR = 90);

