CREATE TABLE [caredata].[EV_WEANINGS] (
    [event_id]       INT             NOT NULL,
    [identity_id]    INT             NOT NULL,
    [sexed]          BIT             CONSTRAINT [DF_EV_WEANINGS_sexed] DEFAULT ((0)) NOT NULL,
    [weaned_boars]   TINYINT         NOT NULL,
    [weaned_gilts]   TINYINT         NOT NULL,
    [substandard]    TINYINT         NULL,
    [litter_weight]  FLOAT (53)      NULL,
    [weaned_group]   VARCHAR (20)    NULL,
    [transport_id]   INT             NULL,
    [destination_id] INT             NULL,
    [ticket_id]      INT             NULL,
    [sow_weight]     FLOAT (53)      NULL,
    [UDF71763]       DATETIME        NULL,
    [UDF26494]       NUMERIC (20, 1) NULL,
    [UDF83100]       VARCHAR (30)    NULL,
    [UDF86942]       NUMERIC (20, 1) NULL,
    [UDF46937]       VARCHAR (30)    NULL,
    [UDF17862]       VARCHAR (30)    NULL,
    [UDF28764]       VARCHAR (30)    NULL,
    [UDF96075]       INT             NULL,
    [UDF39622]       VARCHAR (30)    NULL,
    [UDF3771]        VARCHAR (30)    NULL,
    [UDF56551]       INT             NULL,
    [UDF79924]       VARCHAR (30)    NULL,
    [UDF88534]       VARCHAR (8)     NULL,
    [UDF45344]       VARCHAR (30)    NULL,
    [UDF100652]      DATETIME        NULL,
    [UDF39153]       NUMERIC (20, 1) NULL,
    [UDF76895]       NUMERIC (20, 1) NULL,
    [UDF82195]       INT             NULL,
    [UDF92772]       VARCHAR (30)    NULL,
    [UDF86589]       VARCHAR (30)    NULL,
    [UDF079341]      INT             NULL,
    [UDF061461]      VARCHAR (36)    NULL,
    CONSTRAINT [PK_EV_WEANINGS] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_EV_WEANINGS_BH_EVENTS_0] FOREIGN KEY ([event_id]) REFERENCES [caredata].[BH_EVENTS] ([event_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_EV_WEANINGS_BH_IDENTITIES_1] FOREIGN KEY ([identity_id]) REFERENCES [caredata].[BH_IDENTITIES] ([identity_id]),
    CONSTRAINT [FK_EV_WEANINGS_PACKING_PLANTS_3] FOREIGN KEY ([destination_id]) REFERENCES [caredata].[PACKING_PLANTS] ([packer_id]) ON UPDATE CASCADE,
    CONSTRAINT [FK_EV_WEANINGS_SHIPMENT_TICKETS_4] FOREIGN KEY ([ticket_id]) REFERENCES [caredata].[SHIPMENT_TICKETS] ([ticket_id]) ON DELETE SET NULL,
    CONSTRAINT [FK_EV_WEANINGS_TRANSPORT_COMPANIES_2] FOREIGN KEY ([transport_id]) REFERENCES [caredata].[TRANSPORT_COMPANIES] ([transport_id]) ON UPDATE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX_EV_WEANINGS_event_id]
    ON [caredata].[EV_WEANINGS]([event_id] ASC);

