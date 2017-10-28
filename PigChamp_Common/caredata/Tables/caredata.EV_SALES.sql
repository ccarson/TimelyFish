CREATE TABLE [caredata].[EV_SALES] (
    [event_id]       INT          NOT NULL,
    [identity_id]    INT          NOT NULL,
    [sale_reason_id] INT          NOT NULL,
    [destination_id] INT          NULL,
    [value]          FLOAT (53)   NULL,
    [old_identity]   VARCHAR (15) NULL,
    [UDF058965]      INT          NULL,
    [UDF070778]      VARCHAR (36) NULL,
    CONSTRAINT [PK_EV_SALES] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_EV_SALES_BH_EVENTS_0] FOREIGN KEY ([event_id]) REFERENCES [caredata].[BH_EVENTS] ([event_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_EV_SALES_BH_IDENTITIES_1] FOREIGN KEY ([identity_id]) REFERENCES [caredata].[BH_IDENTITIES] ([identity_id]),
    CONSTRAINT [FK_EV_SALES_CONDITIONS_2] FOREIGN KEY ([sale_reason_id]) REFERENCES [caredata].[CONDITIONS] ([condition_id]) ON UPDATE CASCADE,
    CONSTRAINT [FK_EV_SALES_PACKING_PLANTS_3] FOREIGN KEY ([destination_id]) REFERENCES [caredata].[PACKING_PLANTS] ([packer_id]) ON UPDATE CASCADE
);

