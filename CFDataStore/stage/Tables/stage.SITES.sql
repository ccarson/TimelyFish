CREATE TABLE [stage].[SITES] (
    [site_id]           INT              NOT NULL,
    [reporting_day]     TINYINT          NOT NULL,
    [start_of_year_day] TINYINT          NOT NULL,
    [start_of_year_mth] TINYINT          NOT NULL,
    [zero_date]         DATETIME         NOT NULL,
    [contemp_grp_prds]  TINYINT          NOT NULL,
    [active]            BIT              NOT NULL,
    [currency_unit]     VARCHAR (3)      NULL,
    [weight_unit]       TINYINT          NULL,
    [SequentialGUID]    UNIQUEIDENTIFIER DEFAULT (newsequentialid()) NOT NULL,
    [SourceGUID]        AS               (CONVERT([nvarchar](36),[SequentialGUID])),
    CONSTRAINT [PK_SITES] PRIMARY KEY CLUSTERED ([site_id] ASC)
);



