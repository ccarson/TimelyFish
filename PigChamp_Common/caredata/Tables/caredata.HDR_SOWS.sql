CREATE TABLE [caredata].[HDR_SOWS] (
    [identity_id]      INT          NOT NULL,
    [genetics_id]      INT          NULL,
    [herd_category_id] INT          NULL,
    [date_of_birth]    DATETIME     NULL,
    [name]             VARCHAR (30) NULL,
    [notch]            VARCHAR (30) NULL,
    [sire_identity]    VARCHAR (15) NULL,
    [dam_identity]     VARCHAR (15) NULL,
    [halothane]        VARCHAR (1)  NULL,
    [value]            FLOAT (53)   NULL,
    [weight]           FLOAT (53)   NULL,
    [ebv]              FLOAT (53)   NULL,
    [prior_liveborn]   SMALLINT     NULL,
    [prior_stillborn]  SMALLINT     NULL,
    [prior_weaned]     SMALLINT     NULL,
    [starting_parity]  TINYINT      NULL,
    [service_date]     DATETIME     NULL,
    [weaning_date]     DATETIME     NULL,
    [origin_id]        INT          NULL,
    [ticket_id]        INT          NULL,
    [UDF70434]         INT          NULL,
    [UDF67285]         INT          NULL,
    [UDF74313]         VARCHAR (12) NULL,
    [UDF62226]         INT          NULL,
    [UDF27057]         VARCHAR (12) NULL,
    [UDF16518]         VARCHAR (8)  NULL,
    [UDF39326]         VARCHAR (8)  NULL,
    [UDF74939]         INT          NULL,
    [UDF64769]         VARCHAR (12) NULL,
    [UDF54949]         DATETIME     NULL,
    [UDF35976]         VARCHAR (12) NULL,
    [UDF84003]         VARCHAR (30) NULL,
    [UDF38334]         VARCHAR (12) NULL,
    [UDF94578]         INT          NULL,
    [UDF76703]         VARCHAR (30) NULL,
    [UDF82935]         VARCHAR (30) NULL,
    [UDF8646]          INT          NULL,
    [UDF27400]         DATETIME     NULL,
    [UDF21600]         VARCHAR (10) NULL,
    [UDF33799]         VARCHAR (10) NULL,
    [UDF3682]          VARCHAR (15) NULL,
    [UDF82504]         VARCHAR (15) NULL,
    [UDF89984]         VARCHAR (12) NULL,
    [UDF100738]        INT          NULL,
    [UDF044036]        VARCHAR (36) NULL,
    CONSTRAINT [PK_HDR_SOWS] PRIMARY KEY CLUSTERED ([identity_id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_HDR_SOWS_BH_IDENTITIES_0] FOREIGN KEY ([identity_id]) REFERENCES [caredata].[BH_IDENTITIES] ([identity_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_HDR_SOWS_COMMON_LOOKUPS_2] FOREIGN KEY ([herd_category_id]) REFERENCES [caredata].[COMMON_LOOKUPS] ([lookup_id]) ON UPDATE CASCADE,
    CONSTRAINT [FK_HDR_SOWS_EXTERNAL_FARMS_3] FOREIGN KEY ([origin_id]) REFERENCES [caredata].[EXTERNAL_FARMS] ([farm_id]) ON UPDATE CASCADE,
    CONSTRAINT [FK_HDR_SOWS_GENETICS_1] FOREIGN KEY ([genetics_id]) REFERENCES [caredata].[GENETICS] ([genetics_id]) ON UPDATE CASCADE,
    CONSTRAINT [FK_HDR_SOWS_SHIPMENT_TICKETS_4] FOREIGN KEY ([ticket_id]) REFERENCES [caredata].[SHIPMENT_TICKETS] ([ticket_id]) ON DELETE SET NULL
);


GO
CREATE NONCLUSTERED INDEX [IDX_HDR_SOWS_0]
    ON [caredata].[HDR_SOWS]([genetics_id] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_HDR_SOWS_1]
    ON [caredata].[HDR_SOWS]([herd_category_id] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_HDR_SOWS_2]
    ON [caredata].[HDR_SOWS]([origin_id] ASC) WITH (FILLFACTOR = 80);

