CREATE TABLE [caredata].[GROWTH_CURVES] (
    [growth_curve_id]   INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [growth_curve_name] VARCHAR (30) NOT NULL,
    [unit_of_measure]   TINYINT      NOT NULL,
    [sex_id]            TINYINT      NOT NULL,
    [disabled]          BIT          CONSTRAINT [DF_GROWTH_CURVES_disabled] DEFAULT ((0)) NOT NULL,
    [system]            BIT          NOT NULL,
    [creation_date]     DATETIME     CONSTRAINT [DF_GROWTH_CURVES_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]        VARCHAR (15) CONSTRAINT [DF_GROWTH_CURVES_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date]  DATETIME     NULL,
    [last_update_by]    VARCHAR (15) NULL,
    [deletion_date]     DATETIME     NULL,
    [deleted_by]        VARCHAR (15) NULL,
    CONSTRAINT [PK_GROWTH_CURVES] PRIMARY KEY CLUSTERED ([growth_curve_id] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_GROWTH_CURVES_0]
    ON [caredata].[GROWTH_CURVES]([growth_curve_name] ASC, [deletion_date] ASC) WITH (FILLFACTOR = 90);

