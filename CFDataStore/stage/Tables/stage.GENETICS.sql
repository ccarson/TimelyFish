CREATE TABLE [stage].[GENETICS] (
    [genetics_id]      INT              NOT NULL,
    [supplier_id]      INT              NULL,
    [shortname]        VARCHAR (12)     NOT NULL,
    [longname]         VARCHAR (30)     NOT NULL,
    [sex]              VARCHAR (1)      NULL,
    [disabled]         BIT              NOT NULL,
    [system]           BIT              NOT NULL,
    [synonym]          VARCHAR (5)      NULL,
    [creation_date]    DATETIME         NOT NULL,
    [created_by]       VARCHAR (15)     NOT NULL,
    [last_update_date] DATETIME         NULL,
    [last_update_by]   VARCHAR (15)     NULL,
    [deletion_date]    DATETIME         NULL,
    [deleted_by]       VARCHAR (15)     NULL,
	[unique_id]			[uniqueidentifier] NOT NULL,
   -- [SequentialGUID]   UNIQUEIDENTIFIER DEFAULT (newsequentialid()) NOT NULL,
    [SourceGUID]       AS               (CONVERT([nvarchar](36),[unique_id])),
    CONSTRAINT [PK_GENETICS] PRIMARY KEY CLUSTERED ([genetics_id] ASC)
);





