CREATE TABLE [caredata].[EV_PIGLET_TREATMENTS] (
    [event_id]      INT         NOT NULL,
    [identity_id]   INT         NOT NULL,
    [treatment_id]  INT         NOT NULL,
    [condition_id]  INT         NOT NULL,
    [quantity]      FLOAT (53)  NULL,
    [admin_route]   VARCHAR (3) NULL,
    [broken_needle] BIT         NOT NULL,
    [cost]          FLOAT (53)  NULL,
    [weight]        FLOAT (53)  NULL,
    [piglets]       SMALLINT    NULL,
    CONSTRAINT [PK_EV_PIGLET_TREATMENTS] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_EV_PIGLET_TREATMENTS_BH_EVENTS_0] FOREIGN KEY ([event_id]) REFERENCES [caredata].[BH_EVENTS] ([event_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_EV_PIGLET_TREATMENTS_BH_IDENTITIES_1] FOREIGN KEY ([identity_id]) REFERENCES [caredata].[BH_IDENTITIES] ([identity_id]),
    CONSTRAINT [FK_EV_PIGLET_TREATMENTS_CONDITIONS_3] FOREIGN KEY ([condition_id]) REFERENCES [caredata].[CONDITIONS] ([condition_id]) ON UPDATE CASCADE,
    CONSTRAINT [FK_EV_PIGLET_TREATMENTS_TREATMENTS_2] FOREIGN KEY ([treatment_id]) REFERENCES [caredata].[TREATMENTS] ([treatment_id]) ON UPDATE CASCADE
);

