CREATE TABLE [dbo].[LinkedDocument] (
    [LinkedDocumentID]          INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ContactID]                 INT           NOT NULL,
    [LinkedDocumentTypeID]      INT           NOT NULL,
    [LinkedDocumentDescription] VARCHAR (50)  NULL,
    [Path]                      VARCHAR (150) NULL,
    [IssueDate]                 SMALLDATETIME NULL,
    [ExpirationDate]            SMALLDATETIME NULL,
    CONSTRAINT [PK_LinkedDocument] PRIMARY KEY CLUSTERED ([LinkedDocumentID] ASC) WITH (FILLFACTOR = 90)
);

