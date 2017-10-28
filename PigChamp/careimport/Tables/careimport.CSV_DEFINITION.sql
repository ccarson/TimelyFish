CREATE TABLE [careimport].[CSV_DEFINITION] (
    [definition_id]   INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [definition_name] VARCHAR (25) NOT NULL,
    [group_name]      VARCHAR (50) NULL,
    [import_type]     SMALLINT     NULL,
    CONSTRAINT [PK_CSV_DEFINITION] PRIMARY KEY CLUSTERED ([definition_id] ASC) WITH (FILLFACTOR = 90)
);

