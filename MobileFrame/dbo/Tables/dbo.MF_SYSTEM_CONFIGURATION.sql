CREATE TABLE [dbo].[MF_SYSTEM_CONFIGURATION] (
    [ID]              BIGINT         IDENTITY (0, 1) NOT NULL,
    [CREATE_DATE]     DATETIME       DEFAULT (getutcdate()) NOT NULL,
    [LAST_UPDATE]     DATETIME       DEFAULT (getutcdate()) NOT NULL,
    [CREATED_BY]      BIGINT         DEFAULT ((0)) NOT NULL,
    [LAST_UPDATED_BY] BIGINT         DEFAULT ((0)) NOT NULL,
    [DELETED_BY]      BIGINT         DEFAULT ((-1)) NOT NULL,
    [NAME]            NVARCHAR (35)  NULL,
    [VALUE]           NVARCHAR (255) NULL,
    [DESCRIPTION]     NVARCHAR (255) NULL,
    [READONLY]        INT            NULL,
    [SYNCHTOCLIENT]   INT            NULL,
    [DATA]            IMAGE          NULL,
    CONSTRAINT [MF_SYS_CONFIG_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

