CREATE TABLE [dbo].[SiteComponents] (
    [SiteComponentID]      INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ContactID]            INT          NULL,
    [BuildingID]           INT          NULL,
    [ComponentClassID]     INT          NOT NULL,
    [ComponentTypeID]      INT          NOT NULL,
    [ComponentDescription] VARCHAR (30) NULL,
    CONSTRAINT [PK_SiteComponents] PRIMARY KEY CLUSTERED ([SiteComponentID] ASC) WITH (FILLFACTOR = 90)
);

