CREATE TABLE [caredata].[EV_COHORT_SHIPMENTS] (
    [event_id]         INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [sub_cohort_id]    INT          NOT NULL,
    [shipment_date]    DATETIME     NOT NULL,
    [ticket_id]        INT          NOT NULL,
    [pigs]             SMALLINT     NOT NULL,
    [weight]           FLOAT (53)   NULL,
    [actual_weight]    BIT          CONSTRAINT [DF_EV_COHORT_SHIPMENTS_actual_weight] DEFAULT ((0)) NOT NULL,
    [supervisor_id]    INT          NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_EV_COHORT_SHIPMENTS_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_EV_COHORT_SHIPMENTS_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_EV_COHORT_SHIPMENTS] PRIMARY KEY NONCLUSTERED ([event_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_EV_COHORT_SHIPMENTS_COHORT_LOCATION_RESERVATIONS_0] FOREIGN KEY ([sub_cohort_id]) REFERENCES [caredata].[COHORT_LOCATION_RESERVATIONS] ([sub_cohort_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_EV_COHORT_SHIPMENTS_SHIPMENT_TICKETS_1] FOREIGN KEY ([ticket_id]) REFERENCES [caredata].[SHIPMENT_TICKETS] ([ticket_id]),
    CONSTRAINT [FK_EV_COHORT_SHIPMENTS_SUPERVISORS_2] FOREIGN KEY ([supervisor_id]) REFERENCES [caredata].[SUPERVISORS] ([supervisor_id])
);


GO
CREATE NONCLUSTERED INDEX [IDX_EV_COHORT_SHIPMENTS_0]
    ON [caredata].[EV_COHORT_SHIPMENTS]([supervisor_id] ASC) WITH (FILLFACTOR = 90);

