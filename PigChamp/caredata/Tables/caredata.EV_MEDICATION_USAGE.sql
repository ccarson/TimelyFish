CREATE TABLE [caredata].[EV_MEDICATION_USAGE] (
    [event_id]         INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [site_id]          INT          NOT NULL,
    [sub_cohort_id]    INT          NULL,
    [condition_id]     INT          NULL,
    [treatment_id]     INT          NOT NULL,
    [use_date]         DATETIME     NOT NULL,
    [usage_type]       VARCHAR (1)  NULL,
    [quantity]         INT          NOT NULL,
    [admin_route]      VARCHAR (3)  NULL,
    [pigs_treated]     SMALLINT     NULL,
    [needles_used]     SMALLINT     NULL,
    [needles_broken]   SMALLINT     NULL,
    [supervisor_id]    INT          NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_EV_MEDICATION_USAGE_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_EV_MEDICATION_USAGE_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_EV_MEDICATION_USAGE] PRIMARY KEY NONCLUSTERED ([event_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_EV_MEDICATION_USAGE_COHORT_LOCATION_RESERVATIONS_1] FOREIGN KEY ([sub_cohort_id]) REFERENCES [caredata].[COHORT_LOCATION_RESERVATIONS] ([sub_cohort_id]),
    CONSTRAINT [FK_EV_MEDICATION_USAGE_CONDITIONS_2] FOREIGN KEY ([condition_id]) REFERENCES [caredata].[CONDITIONS] ([condition_id]) ON UPDATE CASCADE,
    CONSTRAINT [FK_EV_MEDICATION_USAGE_SITES_0] FOREIGN KEY ([site_id]) REFERENCES [careglobal].[SITES] ([site_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_EV_MEDICATION_USAGE_SUPERVISORS_4] FOREIGN KEY ([supervisor_id]) REFERENCES [caredata].[SUPERVISORS] ([supervisor_id]) ON UPDATE CASCADE,
    CONSTRAINT [FK_EV_MEDICATION_USAGE_TREATMENTS_3] FOREIGN KEY ([treatment_id]) REFERENCES [caredata].[TREATMENTS] ([treatment_id]) ON UPDATE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IDX_EV_MEDICATION_USAGE_0]
    ON [caredata].[EV_MEDICATION_USAGE]([supervisor_id] ASC) WITH (FILLFACTOR = 90);

