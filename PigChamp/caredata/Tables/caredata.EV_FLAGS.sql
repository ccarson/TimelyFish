CREATE TABLE [caredata].[EV_FLAGS] (
    [event_id]    INT         NOT NULL,
    [identity_id] INT         NOT NULL,
    [flag_id]     INT         NOT NULL,
    [UDF35403]    VARCHAR (8) NULL,
    CONSTRAINT [PK_EV_FLAGS] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_EV_FLAGS_BH_EVENTS_0] FOREIGN KEY ([event_id]) REFERENCES [caredata].[BH_EVENTS] ([event_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_EV_FLAGS_BH_IDENTITIES_1] FOREIGN KEY ([identity_id]) REFERENCES [caredata].[BH_IDENTITIES] ([identity_id]),
    CONSTRAINT [FK_EV_FLAGS_FLAGS_2] FOREIGN KEY ([flag_id]) REFERENCES [caredata].[FLAGS] ([flag_id]) ON UPDATE CASCADE
);

