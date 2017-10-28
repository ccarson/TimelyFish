CREATE TABLE [dbo].[cftSrSvcMgrAsn] (
    [Crtd_DateTime]     SMALLDATETIME NOT NULL,
    [Crtd_Prog]         CHAR (8)      NOT NULL,
    [Crtd_User]         CHAR (10)     NOT NULL,
    [Lupd_DateTime]     SMALLDATETIME NOT NULL,
    [Lupd_Prog]         CHAR (8)      NOT NULL,
    [Lupd_User]         CHAR (10)     NOT NULL,
    [SrSvcMgrContactID] CHAR (6)      NOT NULL,
    [SvcMgrContactID]   CHAR (6)      NOT NULL,
    [tstamp]            ROWVERSION    NOT NULL,
    CONSTRAINT [cftSrSvcMgrAsn0] PRIMARY KEY CLUSTERED ([SrSvcMgrContactID] ASC, [SvcMgrContactID] ASC) WITH (FILLFACTOR = 90)
);

