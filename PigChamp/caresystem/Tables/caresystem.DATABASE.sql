CREATE TABLE [caresystem].[DATABASE] (
    [database_guid]            UNIQUEIDENTIFIER NOT NULL,
    [current_migration_number] SMALLINT         NOT NULL,
    [pclms_server]             VARCHAR (50)     NULL,
    [pclms_port]               SMALLINT         NULL,
    CONSTRAINT [PK_DATABASE] PRIMARY KEY CLUSTERED ([database_guid] ASC) WITH (FILLFACTOR = 90)
);

