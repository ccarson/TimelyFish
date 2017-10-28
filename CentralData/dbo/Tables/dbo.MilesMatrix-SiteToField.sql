CREATE TABLE [dbo].[MilesMatrix-SiteToField] (
    [SiteContactID] INT        NOT NULL,
    [FieldID]       INT        NOT NULL,
    [OneWayMiles]   FLOAT (53) NULL,
    CONSTRAINT [PK_MilesMatrix-SiteToField] PRIMARY KEY CLUSTERED ([SiteContactID] ASC, [FieldID] ASC) WITH (FILLFACTOR = 90)
);

