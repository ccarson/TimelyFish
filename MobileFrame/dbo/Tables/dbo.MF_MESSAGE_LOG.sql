CREATE TABLE [dbo].[MF_MESSAGE_LOG] (
    [ID]              BIGINT         IDENTITY (0, 1) NOT NULL,
    [CREATE_DATE]     DATETIME       DEFAULT (getutcdate()) NOT NULL,
    [LAST_UPDATE]     DATETIME       DEFAULT (getutcdate()) NOT NULL,
    [CREATED_BY]      BIGINT         DEFAULT ((0)) NOT NULL,
    [LAST_UPDATED_BY] BIGINT         DEFAULT ((0)) NOT NULL,
    [DELETED_BY]      BIGINT         DEFAULT ((-1)) NOT NULL,
    [NAME]            NVARCHAR (80)  NULL,
    [FROMLOGIN]       NVARCHAR (40)  NULL,
    [TOLOGIN]         NVARCHAR (40)  NULL,
    [BODY]            NVARCHAR (255) NULL,
    [MESSAGE]         IMAGE          NULL,
    [SENTDATE]        DATETIME       NULL,
    [ACTIONTYPE]      INT            NULL,
    CONSTRAINT [MF_MESSAGE_LOG_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

