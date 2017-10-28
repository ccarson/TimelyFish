CREATE TABLE [dbo].[LinkedDocumentType] (
    [LinkedDocumentTypeID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [LinkedDocumentTypeDescription] VARCHAR (25) NOT NULL,
    CONSTRAINT [PK_LinkedDocumentType] PRIMARY KEY CLUSTERED ([LinkedDocumentTypeID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [Description]
    ON [dbo].[LinkedDocumentType]([LinkedDocumentTypeDescription] ASC) WITH (FILLFACTOR = 90);

