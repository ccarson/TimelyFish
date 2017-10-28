CREATE TABLE [caredata].[BREEDING_COMPANIES] (
    [breeding_id]      INT          NOT NULL,
    [shortname]        VARCHAR (12) NOT NULL,
    [longname]         VARCHAR (30) NOT NULL,
    [disabled]         BIT          CONSTRAINT [DF_BREEDING_COMPANIES_disabled] DEFAULT ((0)) NOT NULL,
    [system]           BIT          CONSTRAINT [DF_BREEDING_COMPANIES_system] DEFAULT ((0)) NOT NULL,
    [synonym]          VARCHAR (5)  NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_BREEDING_COMPANIES_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_BREEDING_COMPANIES_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_BREEDING_COMPANIES] PRIMARY KEY CLUSTERED ([breeding_id] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_BREEDING_COMPANIES_0]
    ON [caredata].[BREEDING_COMPANIES]([shortname] ASC, [deletion_date] ASC) WITH (FILLFACTOR = 80);

