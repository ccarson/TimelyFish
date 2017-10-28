CREATE TABLE [caredata].[TREATMENTS] (
    [treatment_id]        INT          NOT NULL,
    [shortname]           VARCHAR (12) NOT NULL,
    [longname]            VARCHAR (30) NOT NULL,
    [uom]                 VARCHAR (10) NULL,
    [min_usage]           TINYINT      NULL,
    [max_usage]           TINYINT      NULL,
    [administered_method] SMALLINT     CONSTRAINT [DF_TREATMENTS_administered_method] DEFAULT ((1)) NOT NULL,
    [vfd_required]        BIT          CONSTRAINT [DF_TREATMENTS_vfd_required] DEFAULT ((0)) NOT NULL,
    [withdrawal]          TINYINT      NULL,
    [disabled]            BIT          CONSTRAINT [DF_TREATMENTS_disabled] DEFAULT ((0)) NOT NULL,
    [system]              BIT          CONSTRAINT [DF_TREATMENTS_system] DEFAULT ((0)) NOT NULL,
    [synonym]             VARCHAR (5)  NULL,
    [creation_date]       DATETIME     CONSTRAINT [DF_TREATMENTS_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]          VARCHAR (15) CONSTRAINT [DF_TREATMENTS_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date]    DATETIME     NULL,
    [last_update_by]      VARCHAR (15) NULL,
    [deletion_date]       DATETIME     NULL,
    [deleted_by]          VARCHAR (15) NULL,
    CONSTRAINT [PK_TREATMENTS] PRIMARY KEY CLUSTERED ([treatment_id] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_TREATMENTS_0]
    ON [caredata].[TREATMENTS]([shortname] ASC, [deletion_date] ASC) WITH (FILLFACTOR = 80);

