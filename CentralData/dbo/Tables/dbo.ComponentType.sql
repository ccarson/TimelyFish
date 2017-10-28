CREATE TABLE [dbo].[ComponentType] (
    [ComponentTypeID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ComponentTypeDescription] VARCHAR (30) NULL,
    CONSTRAINT [PK_ComponentType] PRIMARY KEY CLUSTERED ([ComponentTypeID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [Description]
    ON [dbo].[ComponentType]([ComponentTypeDescription] ASC) WITH (FILLFACTOR = 90);

