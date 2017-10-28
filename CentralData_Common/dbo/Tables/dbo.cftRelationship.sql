CREATE TABLE [dbo].[cftRelationship] (
    [cftRelationshipID] INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Relationship]      VARCHAR (120) NOT NULL,
    [ActiveFlag]        VARCHAR (3)   NOT NULL,
    [Crtd_dateTime]     DATETIME      NOT NULL,
    [Crtd_User]         VARCHAR (20)  NOT NULL,
    [Lupd_dateTime]     DATETIME      NULL,
    [Lupd_User]         VARCHAR (20)  NULL,
    [Relationship_Type] VARCHAR (20)  NULL,
    CONSTRAINT [PK_cftRelationship] PRIMARY KEY CLUSTERED ([cftRelationshipID] ASC) WITH (FILLFACTOR = 90)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[cftRelationship] TO [hybridconnectionlogin_permissions]
    AS [dbo];
