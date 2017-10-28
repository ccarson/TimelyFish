CREATE TABLE [caredata].[EV_COHORT_INVENTORY] (
    [event_id]         INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [sub_cohort_id]    INT          NOT NULL,
    [inventory_date]   DATETIME     NOT NULL,
    [pigs]             SMALLINT     NOT NULL,
    [weight]           FLOAT (53)   NULL,
    [supervisor_id]    INT          NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_EV_COHORT_INVENTORY_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_EV_COHORT_INVENTORY_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_EV_COHORT_INVENTORY] PRIMARY KEY NONCLUSTERED ([event_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_EV_COHORT_INVENTORY_COHORT_LOCATION_RESERVATIONS_0] FOREIGN KEY ([sub_cohort_id]) REFERENCES [caredata].[COHORT_LOCATION_RESERVATIONS] ([sub_cohort_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_EV_COHORT_INVENTORY_SUPERVISORS_1] FOREIGN KEY ([supervisor_id]) REFERENCES [caredata].[SUPERVISORS] ([supervisor_id]) ON UPDATE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IDX_EV_COHORT_INVENTORY_0]
    ON [caredata].[EV_COHORT_INVENTORY]([supervisor_id] ASC) WITH (FILLFACTOR = 90);

