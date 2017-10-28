CREATE TABLE [dbo].[ManureApplicationCost] (
    [ManureAppId]         INT          NOT NULL,
    [ManureAppCostTypeID] INT          NOT NULL,
    [Amount]              FLOAT (53)   NULL,
    [UnitOfMeasure]       VARCHAR (30) NULL,
    [Comment]             VARCHAR (60) NULL,
    CONSTRAINT [PK_ManureApplicationCost] PRIMARY KEY CLUSTERED ([ManureAppId] ASC, [ManureAppCostTypeID] ASC) WITH (FILLFACTOR = 90)
);

