CREATE TABLE [careglobal].[FILE_IMPORTS] (
    [site_id]          INT           NOT NULL,
    [file_type]        VARCHAR (100) NOT NULL,
    [import_file_path] VARCHAR (300) NULL,
    [import_filename]  VARCHAR (70)  NULL,
    [log_file_path]    VARCHAR (300) NULL,
    [log_file_name]    VARCHAR (70)  NULL,
    [imported_on]      DATETIME      NULL,
    [imported_by]      VARCHAR (15)  NULL,
    [error_count]      INT           NULL,
    [warn_count]       INT           NULL,
    [completed]        BIT           NOT NULL,
    CONSTRAINT [FK_FILE_IMPORTS_SITES_0] FOREIGN KEY ([site_id]) REFERENCES [careglobal].[SITES] ([site_id]) ON DELETE CASCADE
);

