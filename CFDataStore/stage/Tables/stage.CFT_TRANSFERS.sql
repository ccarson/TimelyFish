﻿CREATE TABLE [stage].[CFT_TRANSFERS] (
    [ID]                NVARCHAR (36) NOT NULL,
    [CREATE_DATE]       DATETIME      NOT NULL,
    [LAST_UPDATE]       DATETIME      NOT NULL,
    [CREATED_BY]        BIGINT        NOT NULL,
    [LAST_UPDATED_BY]   BIGINT        NOT NULL,
    [DELETED_BY]        BIGINT        NOT NULL,
    [ANIMALID]          NVARCHAR (36) NULL,
    [SOURCEFARMID]      NVARCHAR (36) NULL,
    [DESTINATIONFARMID] NVARCHAR (36) NULL,
    [TRANSFERDATE]      DATETIME      NULL,
    [REASONID]          INT           NULL,
    [SYNCSTATUS]        NVARCHAR (20) NULL,
    [DataStoreID]       BIGINT        NULL,
    CONSTRAINT [CFT_TRANSFERS_PK] PRIMARY KEY CLUSTERED ([ID] ASC)
);



