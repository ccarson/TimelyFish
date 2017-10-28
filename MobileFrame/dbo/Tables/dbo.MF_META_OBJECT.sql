CREATE TABLE [dbo].[MF_META_OBJECT] (
    [ID]                BIGINT         IDENTITY (0, 1) NOT NULL,
    [CREATE_DATE]       DATETIME       DEFAULT (getutcdate()) NOT NULL,
    [LAST_UPDATE]       DATETIME       DEFAULT (getutcdate()) NOT NULL,
    [CREATED_BY]        BIGINT         DEFAULT ((0)) NOT NULL,
    [LAST_UPDATED_BY]   BIGINT         DEFAULT ((0)) NOT NULL,
    [DELETED_BY]        BIGINT         DEFAULT ((-1)) NOT NULL,
    [NAME]              NVARCHAR (80)  NOT NULL,
    [DESCRIPTION]       NVARCHAR (255) NULL,
    [LABEL]             NVARCHAR (80)  NULL,
    [PLURALLABEL]       NVARCHAR (80)  NULL,
    [SYNCHRONIZE]       INT            DEFAULT ((1)) NOT NULL,
    [SYSTEMOBJECT]      INT            DEFAULT ((0)) NOT NULL,
    [LARGEICON]         IMAGE          NULL,
    [SMALLICON]         IMAGE          NULL,
    [CACHEABLE]         INT            DEFAULT ((0)) NOT NULL,
    [ITEMNAMEATTRIBUTE] NVARCHAR (80)  NULL,
    [CLEANUPAGE]        INT            DEFAULT ((30)) NOT NULL,
    [LASTCLEANUP]       DATETIME       DEFAULT (getutcdate()) NULL,
    CONSTRAINT [MF_META_OBJECT_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

