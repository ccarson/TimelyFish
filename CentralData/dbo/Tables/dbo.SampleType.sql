CREATE TABLE [dbo].[SampleType] (
    [SampleTypeID] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Description]  VARCHAR (30) NULL,
    CONSTRAINT [PK_SampleType] PRIMARY KEY CLUSTERED ([SampleTypeID] ASC) WITH (FILLFACTOR = 90)
);

