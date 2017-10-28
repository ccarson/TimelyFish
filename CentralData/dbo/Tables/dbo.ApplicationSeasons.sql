CREATE TABLE [dbo].[ApplicationSeasons] (
    [ApplicationSeasonID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ApplicationSeasonDescription] VARCHAR (50) NULL,
    CONSTRAINT [PK_ApplicationSeason] PRIMARY KEY CLUSTERED ([ApplicationSeasonID] ASC) WITH (FILLFACTOR = 90)
);

