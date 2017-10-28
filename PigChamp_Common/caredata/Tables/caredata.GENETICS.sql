CREATE TABLE [caredata].[GENETICS] (
    [genetics_id]      INT          NOT NULL,
    [supplier_id]      INT          NULL,
    [shortname]        VARCHAR (12) NOT NULL,
    [longname]         VARCHAR (30) NOT NULL,
    [sex]              VARCHAR (1)  NULL,
    [disabled]         BIT          CONSTRAINT [DF_GENETICS_disabled] DEFAULT ((0)) NOT NULL,
    [system]           BIT          CONSTRAINT [DF_GENETICS_system] DEFAULT ((0)) NOT NULL,
    [synonym]          VARCHAR (5)  NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_GENETICS_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_GENETICS_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_GENETICS] PRIMARY KEY CLUSTERED ([genetics_id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_GENETICS_BREEDING_COMPANIES_0] FOREIGN KEY ([supplier_id]) REFERENCES [caredata].[BREEDING_COMPANIES] ([breeding_id]) ON UPDATE CASCADE
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_GENETICS_0]
    ON [caredata].[GENETICS]([shortname] ASC, [deletion_date] ASC) WITH (FILLFACTOR = 80);

