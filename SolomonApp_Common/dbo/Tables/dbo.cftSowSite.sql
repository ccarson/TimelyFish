CREATE TABLE [dbo].[cftSowSite] (
    [ContactID]     CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [DfltWeanQty]   SMALLINT      NOT NULL,
    [DfltSystem]    CHAR (2)      NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [NoteID]        INT           NOT NULL,
    [WeanDay1]      SMALLINT      NOT NULL,
    [WeanDay2]      SMALLINT      NOT NULL,
    [WeanDay3]      SMALLINT      NOT NULL,
    [WeanDay4]      SMALLINT      NOT NULL,
    [WeanDay5]      SMALLINT      NOT NULL,
    [WeanDay6]      SMALLINT      NOT NULL,
    [WeanRows]      SMALLINT      NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftSowSite0] PRIMARY KEY CLUSTERED ([ContactID] ASC) WITH (FILLFACTOR = 90)
);

