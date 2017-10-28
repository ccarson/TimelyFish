CREATE TABLE [dbo].[SiteSvcMgrAssignment] (
    [SiteSvcMgrAssignmentID] INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SiteContactID]          INT           NOT NULL,
    [SvcMgrContactID]        INT           NULL,
    [EffectiveDate]          SMALLDATETIME NOT NULL,
    CONSTRAINT [PK_SiteServMgrAssignment] PRIMARY KEY CLUSTERED ([SiteContactID] ASC, [EffectiveDate] ASC) WITH (FILLFACTOR = 90)
);

GO
GRANT SELECT
    ON OBJECT::[dbo].[SiteSvcMgrAssignment] TO [hybridconnectionlogin_permissions]
    AS [dbo];


