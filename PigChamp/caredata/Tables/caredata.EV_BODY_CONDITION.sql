CREATE TABLE [caredata].[EV_BODY_CONDITION] (
    [event_id]        INT        NOT NULL,
    [identity_id]     INT        NOT NULL,
    [backfat]         FLOAT (53) NULL,
    [weight]          FLOAT (53) NULL,
    [lesion_score_id] INT        NULL,
    CONSTRAINT [PK_EV_BODY_CONDITION] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_EV_BODY_CONDITION_BH_EVENTS_0] FOREIGN KEY ([event_id]) REFERENCES [caredata].[BH_EVENTS] ([event_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_EV_BODY_CONDITION_BH_IDENTITIES_1] FOREIGN KEY ([identity_id]) REFERENCES [caredata].[BH_IDENTITIES] ([identity_id]),
    CONSTRAINT [FK_EV_BODY_CONDITION_COMMON_LOOKUPS_2] FOREIGN KEY ([lesion_score_id]) REFERENCES [caredata].[COMMON_LOOKUPS] ([lookup_id]) ON DELETE SET NULL
);


GO
CREATE NONCLUSTERED INDEX [IDX_EV_BODY_CONDITION_1]
    ON [caredata].[EV_BODY_CONDITION]([lesion_score_id] ASC) WITH (FILLFACTOR = 80);

