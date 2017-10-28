CREATE TABLE [dbo].[CFT_EVENTTYPE] (
    [ID]              NVARCHAR (36) NOT NULL,
    [CREATE_DATE]     DATETIME      DEFAULT (getutcdate()) NOT NULL,
    [LAST_UPDATE]     DATETIME      DEFAULT (getutcdate()) NOT NULL,
    [CREATED_BY]      BIGINT        DEFAULT ((0)) NOT NULL,
    [LAST_UPDATED_BY] BIGINT        DEFAULT ((0)) NOT NULL,
    [DELETED_BY]      BIGINT        DEFAULT ((-1)) NOT NULL,
    [EVENTNAME]       NVARCHAR (30) NULL,
    [EVENTTYPE]       NVARCHAR (30) NULL,
    [REASONID]        NVARCHAR (10) NULL,
    [STATUS]          INT           NULL,
    [PIGCHAMPHTF]     NVARCHAR (80) NULL
);

