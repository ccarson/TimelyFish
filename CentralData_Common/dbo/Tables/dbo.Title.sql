CREATE TABLE [dbo].[Title] (
    [TitleID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [TitleDescription] VARCHAR (10) NOT NULL,
    CONSTRAINT [PK_Title] PRIMARY KEY CLUSTERED ([TitleDescription] ASC) WITH (FILLFACTOR = 90)
);

