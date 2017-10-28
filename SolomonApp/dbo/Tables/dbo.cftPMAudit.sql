CREATE TABLE [dbo].[cftPMAudit] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [PMAuditID]     INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [PMID]          INT           NOT NULL,
    CONSTRAINT [cftPMAudit0] PRIMARY KEY CLUSTERED ([PMAuditID] ASC) WITH (FILLFACTOR = 90)
);

