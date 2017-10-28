CREATE TABLE [dbo].[MF_LIBRARY_TASK] (
    [ID]                BIGINT         IDENTITY (0, 1) NOT NULL,
    [CREATE_DATE]       DATETIME       DEFAULT (getutcdate()) NOT NULL,
    [LAST_UPDATE]       DATETIME       DEFAULT (getutcdate()) NOT NULL,
    [CREATED_BY]        BIGINT         DEFAULT ((0)) NOT NULL,
    [LAST_UPDATED_BY]   BIGINT         DEFAULT ((0)) NOT NULL,
    [DELETED_BY]        BIGINT         DEFAULT ((-1)) NOT NULL,
    [NAME]              NVARCHAR (80)  NOT NULL,
    [DESCRIPTION]       NVARCHAR (255) NULL,
    [AUTHOR]            BIGINT         NULL,
    [PUBLISHED]         INT            NULL,
    [TASKVERSIONNUMBER] BIGINT         NULL,
    [SCREENLAYOUT]      IMAGE          NULL,
    [ATTRIBUTES]        IMAGE          NULL,
    [NOTES]             NTEXT          NULL,
    CONSTRAINT [MF_LIBRARY_TASK_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [LT_MFU_FK] FOREIGN KEY ([AUTHOR]) REFERENCES [dbo].[MF_USER] ([ID])
);

