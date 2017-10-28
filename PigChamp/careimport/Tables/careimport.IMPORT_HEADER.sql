CREATE TABLE [careimport].[IMPORT_HEADER] (
    [import_id]     INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [definition_id] INT           NOT NULL,
    [site_id]       INT           NOT NULL,
    [import_date]   DATETIME      NOT NULL,
    [replace_date]  DATETIME      NULL,
    [username]      VARCHAR (15)  NOT NULL,
    [filename]      VARCHAR (150) NOT NULL,
    CONSTRAINT [PK_IMPORT_HEADER] PRIMARY KEY CLUSTERED ([import_id] ASC) WITH (FILLFACTOR = 90)
);

