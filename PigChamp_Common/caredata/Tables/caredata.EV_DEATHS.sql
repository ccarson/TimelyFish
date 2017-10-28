CREATE TABLE [caredata].[EV_DEATHS] (
    [event_id]        INT          NOT NULL,
    [identity_id]     INT          NOT NULL,
    [death_reason_id] INT          NOT NULL,
    [old_identity]    VARCHAR (15) NULL,
    [destroyed]       BIT          NULL,
    [UDF094423]       INT          NULL,
    [UDF045631]       VARCHAR (36) NULL,
    CONSTRAINT [PK_EV_DEATHS] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_EV_DEATHS_BH_EVENTS_0] FOREIGN KEY ([event_id]) REFERENCES [caredata].[BH_EVENTS] ([event_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_EV_DEATHS_BH_IDENTITIES_1] FOREIGN KEY ([identity_id]) REFERENCES [caredata].[BH_IDENTITIES] ([identity_id]),
    CONSTRAINT [FK_EV_DEATHS_CONDITIONS_2] FOREIGN KEY ([death_reason_id]) REFERENCES [caredata].[CONDITIONS] ([condition_id]) ON UPDATE CASCADE
);

