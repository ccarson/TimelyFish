CREATE TABLE [caredata].[HDR_BOARS] (
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
    [vasectomized]     SMALLINT     NULL,
    [origin_id]        INT          NULL,
    [UDF19436]         VARCHAR (8)  NULL,
    [UDF083592]        INT          NULL,
    [UDF002298]        VARCHAR (36) NULL,
    CONSTRAINT [PK_HDR_BOARS] PRIMARY KEY CLUSTERED ([identity_id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_HDR_BOARS_BH_IDENTITIES_0] FOREIGN KEY ([identity_id]) REFERENCES [caredata].[BH_IDENTITIES] ([identity_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_HDR_BOARS_COMMON_LOOKUPS_2] FOREIGN KEY ([herd_category_id]) REFERENCES [caredata].[COMMON_LOOKUPS] ([lookup_id]) ON UPDATE CASCADE,
    CONSTRAINT [FK_HDR_BOARS_EXTERNAL_FARMS_3] FOREIGN KEY ([origin_id]) REFERENCES [caredata].[EXTERNAL_FARMS] ([farm_id]) ON UPDATE CASCADE,
    CONSTRAINT [FK_HDR_BOARS_GENETICS_1] FOREIGN KEY ([genetics_id]) REFERENCES [caredata].[GENETICS] ([genetics_id]) ON UPDATE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IDX_HDR_BOARS_0]
    ON [caredata].[HDR_BOARS]([genetics_id] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_HDR_BOARS_1]
    ON [caredata].[HDR_BOARS]([herd_category_id] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_HDR_BOARS_2]
    ON [caredata].[HDR_BOARS]([origin_id] ASC) WITH (FILLFACTOR = 80);

