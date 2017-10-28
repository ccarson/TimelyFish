CREATE TABLE [caredata].[EV_NOTES] (
    [event_id]    INT           NOT NULL,
    [identity_id] INT           NOT NULL,
    [note]        VARCHAR (300) NOT NULL,
    CONSTRAINT [PK_EV_NOTES] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_EV_NOTES_BH_EVENTS_0] FOREIGN KEY ([event_id]) REFERENCES [caredata].[BH_EVENTS] ([event_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_EV_NOTES_BH_IDENTITIES_1] FOREIGN KEY ([identity_id]) REFERENCES [caredata].[BH_IDENTITIES] ([identity_id])
);

