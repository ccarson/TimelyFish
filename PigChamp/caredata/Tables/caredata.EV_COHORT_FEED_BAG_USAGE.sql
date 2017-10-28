CREATE TABLE [caredata].[EV_COHORT_FEED_BAG_USAGE] (
    [event_id]         INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [sub_cohort_id]    INT          NOT NULL,
    [usage_date]       DATETIME     NOT NULL,
    [bags]             SMALLINT     NOT NULL,
    [qty_per_bag]      FLOAT (53)   NULL,
    [cost_per_bag]     FLOAT (53)   NULL,
    [ration_id]        INT          NOT NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_EV_COHORT_FEED_BAG_USAGE_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_EV_COHORT_FEED_BAG_USAGE_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_EV_COHORT_FEED_BAG_USAGE] PRIMARY KEY NONCLUSTERED ([event_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_EV_COHORT_FEED_BAG_USAGE_COHORT_LOCATION_RESERVATIONS_0] FOREIGN KEY ([sub_cohort_id]) REFERENCES [caredata].[COHORT_LOCATION_RESERVATIONS] ([sub_cohort_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_EV_COHORT_FEED_BAG_USAGE_HDR_FEED_RATIONS_1] FOREIGN KEY ([ration_id]) REFERENCES [caredata].[HDR_FEED_RATIONS] ([ration_id])
);

