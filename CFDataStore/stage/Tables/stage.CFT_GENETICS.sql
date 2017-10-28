CREATE TABLE [stage].[CFT_GENETICS] (
    [ID]                    NVARCHAR (36) NOT NULL,
    [CREATE_DATE]           DATETIME      NOT NULL,
    [LAST_UPDATE]           DATETIME      NOT NULL,
    [CREATED_BY]            BIGINT        NOT NULL,
    [LAST_UPDATED_BY]       BIGINT        NOT NULL,
    [DELETED_BY]            BIGINT        NOT NULL,
    [NAME]                  NVARCHAR (30) NULL,
    [SEX]                   NVARCHAR (10) NULL,
    [PIGCHAMP_ID]           BIGINT        NULL,
    [PIGCHAMP_LASTSYNCDATE] DATETIME      NULL,
    [STATUS]                NVARCHAR (1)  NULL,
    CONSTRAINT [CFT_GENETICS_PK] PRIMARY KEY CLUSTERED ([ID] ASC)
);

