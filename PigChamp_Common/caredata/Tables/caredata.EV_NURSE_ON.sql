CREATE TABLE [caredata].[EV_NURSE_ON] (
    [event_id]                  INT        NOT NULL,
    [identity_id]               INT        NOT NULL,
    [piglets_on]                TINYINT    NOT NULL,
    [average_age]               TINYINT    NOT NULL,
    [fostered_weight]           FLOAT (53) NULL,
    [fostered_from_identity_id] INT        NULL,
    CONSTRAINT [PK_EV_NURSE_ON] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_EV_NURSE_ON_BH_EVENTS_0] FOREIGN KEY ([event_id]) REFERENCES [caredata].[BH_EVENTS] ([event_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_EV_NURSE_ON_BH_IDENTITIES_1] FOREIGN KEY ([identity_id]) REFERENCES [caredata].[BH_IDENTITIES] ([identity_id]),
    CONSTRAINT [FK_EV_NURSE_ON_BH_IDENTITIES_2] FOREIGN KEY ([fostered_from_identity_id]) REFERENCES [caredata].[BH_IDENTITIES] ([identity_id])
);


GO
CREATE NONCLUSTERED INDEX [IDX_EV_NURSE_ON_1]
    ON [caredata].[EV_NURSE_ON]([fostered_from_identity_id] ASC)
    INCLUDE([event_id], [piglets_on], [fostered_weight]) WITH (FILLFACTOR = 80);

