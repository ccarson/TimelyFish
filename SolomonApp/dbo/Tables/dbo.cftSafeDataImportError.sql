CREATE TABLE [dbo].[cftSafeDataImportError] (
    [SafeDataImportErrorID] INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ErrDate]               DATETIME      NOT NULL,
    [ErrMessage]            VARCHAR (200) NOT NULL,
    PRIMARY KEY CLUSTERED ([SafeDataImportErrorID] ASC) WITH (FILLFACTOR = 90)
);

