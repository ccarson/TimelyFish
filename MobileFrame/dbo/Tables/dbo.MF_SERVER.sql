﻿CREATE TABLE [dbo].[MF_SERVER] (
    [ID]              BIGINT         IDENTITY (0, 1) NOT NULL,
    [CREATE_DATE]     DATETIME       DEFAULT (getutcdate()) NOT NULL,
    [LAST_UPDATE]     DATETIME       DEFAULT (getutcdate()) NOT NULL,
    [CREATED_BY]      BIGINT         DEFAULT ((0)) NOT NULL,
    [LAST_UPDATED_BY] BIGINT         DEFAULT ((0)) NOT NULL,
    [DELETED_BY]      BIGINT         DEFAULT ((-1)) NOT NULL,
    [NAME]            NVARCHAR (80)  NULL,
    [URL]             NVARCHAR (255) NULL,
    [CONFIGURATION]   IMAGE          NULL,
    CONSTRAINT [MF_SERVER_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

