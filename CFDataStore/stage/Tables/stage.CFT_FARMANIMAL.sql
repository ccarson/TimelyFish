﻿CREATE TABLE [stage].[CFT_FARMANIMAL] (
    [ID]              NVARCHAR (36) NOT NULL,
    [CREATE_DATE]     DATETIME      NOT NULL,
    [LAST_UPDATE]     DATETIME      NOT NULL,
    [CREATED_BY]      BIGINT        NOT NULL,
    [LAST_UPDATED_BY] BIGINT        NOT NULL,
    [DELETED_BY]      BIGINT        NOT NULL,
    [FARMID]          NVARCHAR (36) NULL,
    [ANIMALID]        NVARCHAR (36) NULL,
    [ENTRYDATE]       DATETIME      NULL,
    [REMOVALDATE]     DATETIME      NULL,
    [SYNCSTATUS]      NVARCHAR (20) NULL,
    [MFSYNC]          NVARCHAR (1)  NULL,
    CONSTRAINT [CFT_FARMANIMAL_PK] PRIMARY KEY CLUSTERED ([ID] ASC)
);

