CREATE TABLE [dbo].[SiteManureStructure] (
    [ManureStructureID] INT NOT NULL,
    [ContactID]         INT NOT NULL,
    CONSTRAINT [PK_SiteManureStructure] PRIMARY KEY CLUSTERED ([ManureStructureID] ASC, [ContactID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_SiteManureStructure_ManureStructure] FOREIGN KEY ([ManureStructureID]) REFERENCES [dbo].[ManureStructure] ([ManureStructureID]) ON DELETE CASCADE
);

