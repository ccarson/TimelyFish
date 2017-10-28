CREATE TABLE [caredata].[EV_BOAR_GROUP_LEAVE] (
    [event_id]               INT         NOT NULL,
    [identity_id]            INT         NOT NULL,
    [boar_group_identity_id] INT         NOT NULL,
    [UDF58167]               VARCHAR (8) NULL,
    CONSTRAINT [PK_EV_BOAR_GROUP_LEAVE] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_EV_BOAR_GROUP_LEAVE_BH_EVENTS_0] FOREIGN KEY ([event_id]) REFERENCES [caredata].[BH_EVENTS] ([event_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_EV_BOAR_GROUP_LEAVE_BH_IDENTITIES_1] FOREIGN KEY ([identity_id]) REFERENCES [caredata].[BH_IDENTITIES] ([identity_id]),
    CONSTRAINT [FK_EV_BOAR_GROUP_LEAVE_BH_IDENTITIES_2] FOREIGN KEY ([boar_group_identity_id]) REFERENCES [caredata].[BH_IDENTITIES] ([identity_id])
);

