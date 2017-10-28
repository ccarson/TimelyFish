CREATE TABLE [caredata].[EV_ABORTIONS] (
    [event_id]    INT          NOT NULL,
    [identity_id] INT          NOT NULL,
    [induced]     BIT          CONSTRAINT [DF_EV_ABORTIONS_induced] DEFAULT ((0)) NOT NULL,
    [UDF087493]   INT          NULL,
    [UDF003860]   VARCHAR (36) NULL,
    CONSTRAINT [PK_EV_ABORTIONS] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_EV_ABORTIONS_BH_EVENTS_0] FOREIGN KEY ([event_id]) REFERENCES [caredata].[BH_EVENTS] ([event_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_EV_ABORTIONS_BH_IDENTITIES_1] FOREIGN KEY ([identity_id]) REFERENCES [caredata].[BH_IDENTITIES] ([identity_id])
);

