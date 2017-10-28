CREATE TABLE [stage].[CFT_FARM] (
    [ID]                    NVARCHAR (36) NOT NULL,
    [CREATE_DATE]           DATETIME      NOT NULL,
    [LAST_UPDATE]           DATETIME      NOT NULL,
    [CREATED_BY]            BIGINT        NOT NULL,
    [LAST_UPDATED_BY]       BIGINT        NOT NULL,
    [DELETED_BY]            BIGINT        NOT NULL,
    [NAME]                  NVARCHAR (50) NULL,
    [CONTACTID]             NVARCHAR (10) NULL,
    [STATUS]                INT           NULL,
    [PIGCHAMP_NAME]         NVARCHAR (10) NULL,
    [PIGCHAMP_ID]           BIGINT        NULL,
    [PIGCHAMP_LASTSYNCDATE] DATETIME      NULL,
    [RESULTSPENDING]        INT           NULL,
    CONSTRAINT [CFT_FARM_PK] PRIMARY KEY CLUSTERED ([ID] ASC)
);

