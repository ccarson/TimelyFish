CREATE TABLE [dbo].[cftRelationshipAssignment] (
    [ParentContactID]   INT           NOT NULL,
    [ChildContactID]    INT           NOT NULL,
    [cftRelationshipID] INT           NOT NULL,
    [EffectiveDate]     SMALLDATETIME NOT NULL,
    [Crtd_dateTime]     DATETIME      NOT NULL,
    [Crtd_User]         VARCHAR (20)  NOT NULL,
    [Lupd_dateTime]     DATETIME      NULL,
    [Lupd_User]         VARCHAR (20)  NULL,
    [EndDate]           SMALLDATETIME NULL,
    CONSTRAINT [PK_cftRelationshipAssignment] PRIMARY KEY CLUSTERED ([ParentContactID] ASC, [ChildContactID] ASC, [cftRelationshipID] ASC, [EffectiveDate] ASC) WITH (FILLFACTOR = 90),
    FOREIGN KEY ([cftRelationshipID]) REFERENCES [dbo].[cftRelationship] ([cftRelationshipID]),
    FOREIGN KEY ([ChildContactID]) REFERENCES [dbo].[Contact] ([ContactID]),
    FOREIGN KEY ([ParentContactID]) REFERENCES [dbo].[Contact] ([ContactID])
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[cftRelationshipAssignment] TO [hybridconnectionlogin_permissions]
    AS [dbo];
