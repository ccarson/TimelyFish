CREATE TABLE [dbo].[ProductionSystem] (
    [ProductionSystemID]          SMALLINT     NOT NULL,
    [ProductionSystemDescription] VARCHAR (30) NULL,
    CONSTRAINT [PK_ProductionSystem] PRIMARY KEY CLUSTERED ([ProductionSystemID] ASC) WITH (FILLFACTOR = 90)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionSystem] TO [hybridconnectionlogin_permissions]
    AS [dbo];

