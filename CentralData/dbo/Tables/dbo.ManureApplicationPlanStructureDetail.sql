CREATE TABLE [dbo].[ManureApplicationPlanStructureDetail] (
    [ManureApplicationPlanID] INT NOT NULL,
    [ManureStructureID]       INT NOT NULL,
    CONSTRAINT [PK_ManureApplicationPlanStructureDetail] PRIMARY KEY CLUSTERED ([ManureApplicationPlanID] ASC, [ManureStructureID] ASC) WITH (FILLFACTOR = 90)
);

