CREATE TABLE [caredata].[HDR_COHORTS] (
    [cohort_id]        INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [site_id]          INT          NOT NULL,
    [cohort_name]      VARCHAR (20) NOT NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_HDR_COHORTS_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_HDR_COHORTS_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_HDR_COHORTS] PRIMARY KEY NONCLUSTERED ([cohort_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_HDR_COHORTS_SITES_0] FOREIGN KEY ([site_id]) REFERENCES [careglobal].[SITES] ([site_id])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_HDR_COHORTS_0]
    ON [caredata].[HDR_COHORTS]([cohort_name] ASC, [site_id] ASC, [deletion_date] ASC) WITH (FILLFACTOR = 90);

