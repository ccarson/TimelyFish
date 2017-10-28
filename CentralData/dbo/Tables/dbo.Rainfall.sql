CREATE TABLE [dbo].[Rainfall] (
    [SiteContactID]  INT           NOT NULL,
    [RainfallDate]   SMALLDATETIME NOT NULL,
    [RainfallAmount] FLOAT (53)    NOT NULL,
    CONSTRAINT [PK_Rainfall] PRIMARY KEY CLUSTERED ([SiteContactID] ASC, [RainfallDate] ASC) WITH (FILLFACTOR = 90)
);

