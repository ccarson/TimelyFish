CREATE TABLE [dbo].[cftRelatedContact] (
    [ContactID]        CHAR (6)      NOT NULL,
    [Crtd_DateTime]    SMALLDATETIME NOT NULL,
    [Crtd_Prog]        CHAR (8)      NOT NULL,
    [Crtd_User]        CHAR (10)     NOT NULL,
    [Lupd_DateTime]    SMALLDATETIME NOT NULL,
    [Lupd_Prog]        CHAR (8)      NOT NULL,
    [Lupd_User]        CHAR (10)     NOT NULL,
    [RelatedContactID] CHAR (6)      NOT NULL,
    [SummaryOfDetail]  CHAR (100)    NOT NULL,
    [tstamp]           ROWVERSION    NULL,
    CONSTRAINT [cftRelatedContact0] PRIMARY KEY CLUSTERED ([RelatedContactID] ASC, [ContactID] ASC) WITH (FILLFACTOR = 90)
);

