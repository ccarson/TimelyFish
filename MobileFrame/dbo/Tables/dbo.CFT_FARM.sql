CREATE TABLE [dbo].[CFT_FARM] (
    [ID]                    NVARCHAR (36) NOT NULL,
    [CREATE_DATE]           DATETIME      DEFAULT (getutcdate()) NOT NULL,
    [LAST_UPDATE]           DATETIME      DEFAULT (getutcdate()) NOT NULL,
    [CREATED_BY]            BIGINT        DEFAULT ((0)) NOT NULL,
    [LAST_UPDATED_BY]       BIGINT        DEFAULT ((0)) NOT NULL,
    [DELETED_BY]            BIGINT        DEFAULT ((-1)) NOT NULL,
    [NAME]                  NVARCHAR (50) NULL,
    [CONTACTID]             NVARCHAR (10) NULL,
    [STATUS]                INT           NULL,
    [PIGCHAMP_NAME]         NVARCHAR (10) NULL,
    [PIGCHAMP_ID]           BIGINT        NULL,
    [PIGCHAMP_LASTSYNCDATE] DATETIME      NULL,
    [TREATMENTS]            INT           NULL,
    [MULTILANGUAGE]         INT           NULL,
    [REDLIGHTMIN]           INT           NULL,
    [RESULTSPENDINGNBR]     INT           NULL,
    [MFSTARTDATE]           DATETIME      NULL,
    CONSTRAINT [CFT_FARM_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

