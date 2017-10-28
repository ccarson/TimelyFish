CREATE TABLE [caredata].[EV_COHORT_PLACEMENTS] (
    [event_id]           INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [sub_cohort_id]      INT          NOT NULL,
    [sub_cohort_from_id] INT          NULL,
    [ticket_id]          INT          NULL,
    [placement_date]     DATETIME     NOT NULL,
    [pigs]               SMALLINT     NOT NULL,
    [weight]             FLOAT (53)   NULL,
    [value]              FLOAT (53)   NULL,
    [sex_id]             TINYINT      NULL,
    [genetics_id]        INT          NULL,
    [pig_type_id]        INT          NULL,
    [supervisor_id]      INT          NULL,
    [creation_date]      DATETIME     CONSTRAINT [DF_EV_COHORT_PLACEMENTS_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]         VARCHAR (15) CONSTRAINT [DF_EV_COHORT_PLACEMENTS_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date]   DATETIME     NULL,
    [last_update_by]     VARCHAR (15) NULL,
    [deletion_date]      DATETIME     NULL,
    [deleted_by]         VARCHAR (15) NULL,
    CONSTRAINT [PK_EV_COHORT_PLACEMENTS] PRIMARY KEY NONCLUSTERED ([event_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_EV_COHORT_PLACEMENTS_COHORT_LOCATION_RESERVATIONS_0] FOREIGN KEY ([sub_cohort_id]) REFERENCES [caredata].[COHORT_LOCATION_RESERVATIONS] ([sub_cohort_id]),
    CONSTRAINT [FK_EV_COHORT_PLACEMENTS_COHORT_LOCATION_RESERVATIONS_1] FOREIGN KEY ([sub_cohort_from_id]) REFERENCES [caredata].[COHORT_LOCATION_RESERVATIONS] ([sub_cohort_id]) ON DELETE SET NULL,
    CONSTRAINT [FK_EV_COHORT_PLACEMENTS_COMMON_LOOKUPS_4] FOREIGN KEY ([pig_type_id]) REFERENCES [caredata].[COMMON_LOOKUPS] ([lookup_id]) ON UPDATE CASCADE,
    CONSTRAINT [FK_EV_COHORT_PLACEMENTS_GENETICS_3] FOREIGN KEY ([genetics_id]) REFERENCES [caredata].[GENETICS] ([genetics_id]) ON UPDATE CASCADE,
    CONSTRAINT [FK_EV_COHORT_PLACEMENTS_SHIPMENT_TICKETS_2] FOREIGN KEY ([ticket_id]) REFERENCES [caredata].[SHIPMENT_TICKETS] ([ticket_id]),
    CONSTRAINT [FK_EV_COHORT_PLACEMENTS_SUPERVISORS_5] FOREIGN KEY ([supervisor_id]) REFERENCES [caredata].[SUPERVISORS] ([supervisor_id]) ON UPDATE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IDX_EV_COHORT_PLACEMENTS_0]
    ON [caredata].[EV_COHORT_PLACEMENTS]([supervisor_id] ASC) WITH (FILLFACTOR = 90);

