CREATE TABLE [dbo].[cftTriumphDataImport] (
    [TriumphDataImportID] INT          IDENTITY (1, 1) NOT NULL,
    [ImportFileName]      VARCHAR (50) NOT NULL,
    [ImportedDateTime]    DATETIME     NULL,
    PRIMARY KEY CLUSTERED ([TriumphDataImportID] ASC) WITH (FILLFACTOR = 90)
);

