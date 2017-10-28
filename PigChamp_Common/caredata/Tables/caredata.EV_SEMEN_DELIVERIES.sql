CREATE TABLE [caredata].[EV_SEMEN_DELIVERIES] (
    [event_id]    INT          NOT NULL,
    [identity_id] INT          NOT NULL,
    [source_id]   INT          NULL,
    [genetics_id] INT          NULL,
    [pooled]      BIT          NULL,
    [UDF79619]    VARCHAR (30) NULL,
    [UDF86711]    VARCHAR (8)  NULL,
    [UDF90624]    VARCHAR (8)  NULL,
    CONSTRAINT [PK_EV_SEMEN_DELIVERIES] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_EV_SEMEN_DELIVERIES_AI_STUDS_2] FOREIGN KEY ([source_id]) REFERENCES [caredata].[AI_STUDS] ([stud_id]) ON UPDATE CASCADE,
    CONSTRAINT [FK_EV_SEMEN_DELIVERIES_BH_EVENTS_0] FOREIGN KEY ([event_id]) REFERENCES [caredata].[BH_EVENTS] ([event_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_EV_SEMEN_DELIVERIES_BH_IDENTITIES_1] FOREIGN KEY ([identity_id]) REFERENCES [caredata].[BH_IDENTITIES] ([identity_id]),
    CONSTRAINT [FK_EV_SEMEN_DELIVERIES_GENETICS_3] FOREIGN KEY ([genetics_id]) REFERENCES [caredata].[GENETICS] ([genetics_id]) ON UPDATE CASCADE
);

