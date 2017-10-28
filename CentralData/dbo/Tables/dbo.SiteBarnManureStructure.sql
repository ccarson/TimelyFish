CREATE TABLE [dbo].[SiteBarnManureStructure] (
    [ContactID]         INT NOT NULL,
    [BarnID]            INT NOT NULL,
    [ManureStructureID] INT NOT NULL,
    CONSTRAINT [PK_SiteBarnManureStructure] PRIMARY KEY CLUSTERED ([ContactID] ASC, [BarnID] ASC, [ManureStructureID] ASC) WITH (FILLFACTOR = 90)
);

