CREATE TABLE [careglobal].[FILE_EXPORTS] (
    [site_id]          INT           NOT NULL,
    [file_type]        VARCHAR (100) NOT NULL,
    [sequence]         INT           NULL,
    [export_file_path] VARCHAR (300) NULL,
    [export_filename]  VARCHAR (70)  NULL,
    [exported_on]      DATETIME      NULL,
    [exported_by]      VARCHAR (15)  NULL,
    [completed]        BIT           NOT NULL,
    CONSTRAINT [FK_FILE_EXPORTS_SITES_0] FOREIGN KEY ([site_id]) REFERENCES [careglobal].[SITES] ([site_id]) ON DELETE CASCADE
);

