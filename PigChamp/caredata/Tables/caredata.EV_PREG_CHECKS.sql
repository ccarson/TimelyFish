CREATE TABLE [caredata].[EV_PREG_CHECKS] (
    [event_id]     INT          NOT NULL,
    [identity_id]  INT          NOT NULL,
    [test_type_id] INT          NULL,
    [result]       VARCHAR (1)  NOT NULL,
    [UDF26546]     VARCHAR (8)  NULL,
    [UDF89152]     VARCHAR (18) NULL,
    [UDF27267]     INT          NULL,
    [UDF091887]    INT          NULL,
    [UDF061831]    VARCHAR (36) NULL,
    CONSTRAINT [PK_EV_PREG_CHECKS] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_EV_PREG_CHECKS_BH_EVENTS_0] FOREIGN KEY ([event_id]) REFERENCES [caredata].[BH_EVENTS] ([event_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_EV_PREG_CHECKS_BH_IDENTITIES_1] FOREIGN KEY ([identity_id]) REFERENCES [caredata].[BH_IDENTITIES] ([identity_id]),
    CONSTRAINT [FK_EV_PREG_CHECKS_COMMON_LOOKUPS_2] FOREIGN KEY ([test_type_id]) REFERENCES [caredata].[COMMON_LOOKUPS] ([lookup_id]) ON UPDATE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IDX_EV_PREG_CHECKS_1]
    ON [caredata].[EV_PREG_CHECKS]([test_type_id] ASC) WITH (FILLFACTOR = 80);

