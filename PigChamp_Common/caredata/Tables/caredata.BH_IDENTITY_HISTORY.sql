CREATE TABLE [caredata].[BH_IDENTITY_HISTORY] (
    [site_id]          INT          NOT NULL,
    [is_current_site]  BIT          CONSTRAINT [DF_BH_IDENTITY_HISTORY_is_current_site] DEFAULT ((1)) NOT NULL,
    [identity_id]      INT          NOT NULL,
    [identity_type]    VARCHAR (1)  NOT NULL,
    [primary_identity] VARCHAR (15) NOT NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_BH_IDENTITY_HISTORY] PRIMARY KEY CLUSTERED ([identity_id] ASC, [site_id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_BH_IDENTITY_HISTORY_BH_IDENTITIES_1] FOREIGN KEY ([identity_id]) REFERENCES [caredata].[BH_IDENTITIES] ([identity_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_BH_IDENTITY_HISTORY_SITES_0] FOREIGN KEY ([site_id]) REFERENCES [careglobal].[SITES] ([site_id])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_BH_IDENTITY_HISTORY_0]
    ON [caredata].[BH_IDENTITY_HISTORY]([site_id] ASC, [identity_type] ASC, [primary_identity] ASC, [is_current_site] ASC, [deletion_date] ASC)
    INCLUDE([identity_id]) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_BH_IDENTITY_HISTORY_1]
    ON [caredata].[BH_IDENTITY_HISTORY]([site_id] ASC, [is_current_site] ASC)
    INCLUDE([identity_type], [primary_identity]) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_BH_IDENTITY_HISTORY_2]
    ON [caredata].[BH_IDENTITY_HISTORY]([identity_type] ASC, [site_id] ASC, [is_current_site] ASC, [deletion_date] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_BH_IDENTITY_HISTORY_4]
    ON [caredata].[BH_IDENTITY_HISTORY]([site_id] ASC, [identity_id] ASC, [deletion_date] ASC)
    INCLUDE([primary_identity]) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_BH_IDENTITY_HISTORY_5]
    ON [caredata].[BH_IDENTITY_HISTORY]([primary_identity] ASC, [site_id] ASC, [identity_type] ASC)
    INCLUDE([identity_id]) WITH (FILLFACTOR = 80);

