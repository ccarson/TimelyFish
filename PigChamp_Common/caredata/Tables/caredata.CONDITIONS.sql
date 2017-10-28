CREATE TABLE [caredata].[CONDITIONS] (
    [condition_id]     INT          NOT NULL,
    [shortname]        VARCHAR (12) NOT NULL,
    [longname]         VARCHAR (30) NOT NULL,
    [treatable]        BIT          CONSTRAINT [DF_CONDITIONS_treatable] DEFAULT ((0)) NOT NULL,
    [disposable]       BIT          CONSTRAINT [DF_CONDITIONS_disposable] DEFAULT ((0)) NOT NULL,
    [excl_adj_far]     BIT          CONSTRAINT [DF_CONDITIONS_excl_adj_far] DEFAULT ((1)) NOT NULL,
    [sow_gilts]        BIT          CONSTRAINT [DF_CONDITIONS_sow_gilts] DEFAULT ((0)) NOT NULL,
    [sow_inpig]        BIT          CONSTRAINT [DF_CONDITIONS_sow_inpig] DEFAULT ((0)) NOT NULL,
    [sow_lactating]    BIT          CONSTRAINT [DF_CONDITIONS_sow_lactating] DEFAULT ((0)) NOT NULL,
    [sow_dry]          BIT          CONSTRAINT [DF_CONDITIONS_sow_dry] DEFAULT ((0)) NOT NULL,
    [boar]             BIT          CONSTRAINT [DF_CONDITIONS_boar] DEFAULT ((0)) NOT NULL,
    [piglets]          BIT          CONSTRAINT [DF_CONDITIONS_piglets] DEFAULT ((0)) NOT NULL,
    [growfinish]       BIT          CONSTRAINT [DF_CONDITIONS_growfinish] DEFAULT ((0)) NOT NULL,
    [disabled]         BIT          CONSTRAINT [DF_CONDITIONS_disabled] DEFAULT ((0)) NOT NULL,
    [system]           BIT          CONSTRAINT [DF_CONDITIONS_system] DEFAULT ((0)) NOT NULL,
    [synonym]          VARCHAR (5)  NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_CONDITIONS_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_CONDITIONS_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_CONDITIONS] PRIMARY KEY CLUSTERED ([condition_id] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_CONDITIONS_0]
    ON [caredata].[CONDITIONS]([shortname] ASC, [deletion_date] ASC) WITH (FILLFACTOR = 80);

