CREATE TABLE [caredata].[EV_RETAG] (
    [event_id]     INT          NOT NULL,
    [identity_id]  INT          NOT NULL,
    [old_identity] VARCHAR (15) NULL,
    [UDF70728]     INT          NULL,
    CONSTRAINT [PK_EV_RETAG] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_EV_RETAG_BH_EVENTS_0] FOREIGN KEY ([event_id]) REFERENCES [caredata].[BH_EVENTS] ([event_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_EV_RETAG_BH_IDENTITIES_1] FOREIGN KEY ([identity_id]) REFERENCES [caredata].[BH_IDENTITIES] ([identity_id])
);

