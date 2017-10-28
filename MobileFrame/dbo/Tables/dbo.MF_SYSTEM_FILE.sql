CREATE TABLE [dbo].[MF_SYSTEM_FILE] (
    [ID]              BIGINT        IDENTITY (0, 1) NOT NULL,
    [CREATE_DATE]     DATETIME      DEFAULT (getutcdate()) NOT NULL,
    [LAST_UPDATE]     DATETIME      DEFAULT (getutcdate()) NOT NULL,
    [CREATED_BY]      BIGINT        DEFAULT ((0)) NOT NULL,
    [LAST_UPDATED_BY] BIGINT        DEFAULT ((0)) NOT NULL,
    [DELETED_BY]      BIGINT        DEFAULT ((-1)) NOT NULL,
    [NAME]            NVARCHAR (80) NULL,
    [PLATFORM]        INT           NULL,
    [TYPE]            INT           NULL,
    [FILES]           IMAGE         NULL,
    CONSTRAINT [MF_SYSTEM_FILE_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

