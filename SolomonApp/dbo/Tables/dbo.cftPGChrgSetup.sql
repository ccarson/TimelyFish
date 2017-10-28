CREATE TABLE [dbo].[cftPGChrgSetup] (
    [Crtd_DateTime]  SMALLDATETIME NOT NULL,
    [Crtd_Prog]      CHAR (8)      NOT NULL,
    [Crtd_User]      CHAR (10)     NOT NULL,
    [Deathacct]      CHAR (16)     NOT NULL,
    [Lupd_DateTime]  SMALLDATETIME NOT NULL,
    [Lupd_Prog]      CHAR (8)      NOT NULL,
    [Lupd_User]      CHAR (10)     NOT NULL,
    [Moveacct]       CHAR (16)     NOT NULL,
    [MoveInacct]     CHAR (16)     NULL,
    [NoteID]         INT           NOT NULL,
    [Purchacct]      CHAR (16)     NOT NULL,
    [SiteCostAcct]   CHAR (16)     NULL,
    [SiteCostOffset] CHAR (16)     NULL,
    [TranInacct]     CHAR (16)     NOT NULL,
    [tstamp]         ROWVERSION    NULL
);

