CREATE TABLE [dbo].[ProdSvcMgrAssignment] (
    [ProdSvcMgrAssignmentID] INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SiteContactID]          INT           NOT NULL,
    [ProdSvcMgrContactID]    INT           NOT NULL,
    [EffectiveDate]          SMALLDATETIME NOT NULL,
    CONSTRAINT [PK_ProdSvcMgrAssignmentID] PRIMARY KEY CLUSTERED ([SiteContactID] ASC, [EffectiveDate] ASC) WITH (FILLFACTOR = 90)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProdSvcMgrAssignment] TO [hybridconnectionlogin_permissions]
    AS [dbo];

