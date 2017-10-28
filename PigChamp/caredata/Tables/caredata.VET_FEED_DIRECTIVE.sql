CREATE TABLE [caredata].[VET_FEED_DIRECTIVE] (
    [vfd_id]           INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [site_id]          INT          NOT NULL,
    [cohort_id]        INT          NULL,
    [date_issued]      DATETIME     NOT NULL,
    [date_expires]     DATETIME     NOT NULL,
    [vet_id]           INT          NOT NULL,
    [treatment_id]     INT          NOT NULL,
    [condition_id]     INT          NULL,
    [name]             VARCHAR (30) NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_VET_FEED_DIRECTIVE_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_VET_FEED_DIRECTIVE_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_VET_FEED_DIRECTIVE] PRIMARY KEY NONCLUSTERED ([vfd_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_VET_FEED_DIRECTIVE_CONDITIONS_4] FOREIGN KEY ([condition_id]) REFERENCES [caredata].[CONDITIONS] ([condition_id]) ON UPDATE CASCADE,
    CONSTRAINT [FK_VET_FEED_DIRECTIVE_HDR_COHORTS_1] FOREIGN KEY ([cohort_id]) REFERENCES [caredata].[HDR_COHORTS] ([cohort_id]),
    CONSTRAINT [FK_VET_FEED_DIRECTIVE_SITES_0] FOREIGN KEY ([site_id]) REFERENCES [careglobal].[SITES] ([site_id]),
    CONSTRAINT [FK_VET_FEED_DIRECTIVE_TREATMENTS_3] FOREIGN KEY ([treatment_id]) REFERENCES [caredata].[TREATMENTS] ([treatment_id]) ON UPDATE CASCADE,
    CONSTRAINT [FK_VET_FEED_DIRECTIVE_VETERINARIANS_2] FOREIGN KEY ([vet_id]) REFERENCES [caredata].[VETERINARIANS] ([vet_id]) ON UPDATE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IDX_VET_FEED_DIRECTIVE_0]
    ON [caredata].[VET_FEED_DIRECTIVE]([date_issued] ASC) WITH (FILLFACTOR = 90);

