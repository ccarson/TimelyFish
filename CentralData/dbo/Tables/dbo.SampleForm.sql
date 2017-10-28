CREATE TABLE [dbo].[SampleForm] (
    [SampleFormID] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Description]  VARCHAR (30) NULL,
    CONSTRAINT [PK_SampleForm] PRIMARY KEY CLUSTERED ([SampleFormID] ASC) WITH (FILLFACTOR = 90)
);

