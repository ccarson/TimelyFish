CREATE TABLE [dbo].[cftMktMgrAssign] (
    [Crtd_DateTime]   SMALLDATETIME NULL,
    [Crtd_Prog]       CHAR (8)      NULL,
    [Crtd_User]       CHAR (10)     NULL,
    [EffectiveDate]   SMALLDATETIME NULL,
    [Lupd_DateTime]   SMALLDATETIME NULL,
    [Lupd_Prog]       CHAR (8)      NULL,
    [Lupd_User]       CHAR (10)     NULL,
    [MktMgrContactID] CHAR (6)      NULL,
    [SiteContactID]   CHAR (6)      NULL,
    [tstamp]          ROWVERSION    NULL
);

