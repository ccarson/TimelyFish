CREATE TABLE [dbo].[TruckerType] (
    [TruckerTypeID] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Description]   VARCHAR (20) NULL,
    CONSTRAINT [PK_TruckerType] PRIMARY KEY CLUSTERED ([TruckerTypeID] ASC) WITH (FILLFACTOR = 90)
);

