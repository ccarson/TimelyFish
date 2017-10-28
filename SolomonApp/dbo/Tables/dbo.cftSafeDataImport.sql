CREATE TABLE [dbo].[cftSafeDataImport] (
    [SafeDataImportID] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ImportFileName]   VARCHAR (50) NOT NULL,
    [ImportedDateTime] DATETIME     NULL,
    PRIMARY KEY CLUSTERED ([SafeDataImportID] ASC) WITH (FILLFACTOR = 90)
);

