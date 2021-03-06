﻿CREATE TABLE [dbo].[CFT_FARM_TARGET] (
    [ID]              BIGINT        IDENTITY (0, 1) NOT NULL,
    [CREATE_DATE]     DATETIME      DEFAULT (getutcdate()) NOT NULL,
    [LAST_UPDATE]     DATETIME      DEFAULT (getutcdate()) NOT NULL,
    [CREATED_BY]      BIGINT        DEFAULT ((0)) NOT NULL,
    [LAST_UPDATED_BY] BIGINT        DEFAULT ((0)) NOT NULL,
    [DELETED_BY]      BIGINT        DEFAULT ((-1)) NOT NULL,
    [FARMID]          NVARCHAR (36) NULL,
    [TARGETID]        BIGINT        NULL,
    [TARGET]          FLOAT (53)    NULL,
    [TARGETSTARTDATE] DATETIME      NULL,
    [TARGETENDDATE]   DATETIME      NULL,
    [CREATEDBY]       NVARCHAR (80) NULL,
    [CREATEDDATE]     DATETIME      NULL,
    [ANIMALTYPE]      INT           NULL,
    CONSTRAINT [CFT_FARM_TARGET_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

