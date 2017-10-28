CREATE TABLE [caredata].[HDR_PIGLET_IDENTITIES] (
    [event_id]         INT          NOT NULL,
    [primary_identity] VARCHAR (20) NOT NULL,
    [sex_id]           SMALLINT     NULL,
    [identity_id]      INT          NOT NULL,
    CONSTRAINT [FK_HDR_PIGLET_IDENTITIES_BH_EVENTS_0] FOREIGN KEY ([event_id]) REFERENCES [caredata].[BH_EVENTS] ([event_id]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IDX_HDR_PIGLET_IDENTITIES_0]
    ON [caredata].[HDR_PIGLET_IDENTITIES]([event_id] ASC)
    INCLUDE([primary_identity], [sex_id]) WITH (FILLFACTOR = 90);

